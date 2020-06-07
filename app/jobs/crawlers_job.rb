class CrawlersJob < ApplicationJob
  queue_as :crawler
  # Fetch the web pages by url
  # @param [Source] object
  # @param [String] url
  # @param [Mixed] unique_id
  def perform(object, url, unique_id: nil)
    userdics = Hash.new
    Configs::MecabDic.each do |dic|
      userdics[dic.language_code] = File.join(
        Newsdict::Application.config.path_of_mecab_dict_dir,
        "#{dic.key}.dic")
    end
    web_stat = WebStat.stat_by_url(url, userdics: userdics)
    attrs = Contents::Web.set_attributes_by_web_stat(object, web_stat)
    # Record unique ID to prevent duplicate registration
    attrs[:unique_id] = unique_id
    Contents::Web.save_form_job(attrs)
  end
end