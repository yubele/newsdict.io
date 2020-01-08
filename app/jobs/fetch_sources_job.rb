class FetchSourcesJob < ApplicationJob
  queue_as :default
  
  # Fetch the web pages by url
  # @param [Object] object
  # @param [String] url
  def perform(object, url)
    userdics = Hash.new
    Configs::MecabDic.each do |dic|
      userdics[dic.language_code] = File.join(
        Newsdict::Application.config.path_of_mecab_dict_dir,
        "#{dic.key}.dic")
    end
    web_stat = WebStat.stat_by_url(url, userdics: userdics)
    attrs = {
        :title => web_stat[:title],
        :site_name => web_stat[:site_name],
        :content => web_stat[:content],
        :expanded_url => web_stat[:url],
        :language_code => web_stat[:language_code],
        :tags => web_stat[:tags],
        :source_id => object.id,
        :user_id => object.user_id
    }
    # image
    unless web_stat[:eyecatch_image_path].nil?
      image = MiniMagick::Image.read(File.read(web_stat[:eyecatch_image_path]))
      image.resize "128x"
      attrs[:image_blob] = BSON::Binary.new(image.to_blob)
    end
    # Check duplicated news
    if content = Contents::Web.find_by(expanded_url: web_stat[:url]) ||
        content = Contents::Web.find_by(title: web_stat[:title])
      content.update_attributes(attrs)
    else
      Contents::Web.new(attrs).save
    end
  end
end