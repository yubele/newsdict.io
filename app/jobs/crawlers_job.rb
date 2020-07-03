class CrawlersJob < ApplicationJob
  queue_as :crawlers
  # Fetch the web pages by url
  # @param [Source] object
  # @param [String] url
  # @param [Mixed] unique_id
  def perform(object, url, unique_id: nil)
    return nil if ::Filters::IgnoreCrawlContent.where(exclude_url: url).exists?
    userdics = Hash.new
    Configs::MecabDic.each do |dic|
      userdics[dic.language_code] = Array.new unless userdics.include?(dic.language_code)
      userdic = File.join(Newsdict::Application.config.path_of_mecab_dict_dir, "#{dic.key}.dic")
      if File.exist?(userdic)
        userdics[dic.language_code] << userdic
      end
    end
    web_stat = WebStat.stat_by_url(url, userdics: userdics.map {|k,v| [k, v.join(",")]}.to_h )
    attrs = Contents::Web.set_attributes_by_web_stat(object, web_stat)
    # Record unique ID to prevent duplicate registration
    attrs[:unique_id] = unique_id
    Contents::Web.save_form_job(attrs)
  rescue Mechanize::RobotsDisallowedError,
          Mechanize::ResponseCodeError => e
    ignore = ::Filters::IgnoreCrawlContent.new
    ignore.exclude_url = url
    ignore.message = e
    ignore.save
  end
end