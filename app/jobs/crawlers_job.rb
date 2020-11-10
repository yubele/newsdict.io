class CrawlersJob < ApplicationJob
  queue_as :crawlers
  # Fetch the web pages by url
  # @param [Source] object
  # @param [String] url
  # @param [Mixed] unique_id
  def perform(object, url, unique_id: nil)
    return nil if ::Filters::IgnoreCrawlContent.where(exclude_url: url).exists?
    web_stat = WebStat.stat_by_url(url, userdics: Configs::MecabDic.userdics )
    case(object.class)
    when Sources::TwitterAccount
      attrs = Contents::Tweet.set_attributes_by_web_stat(object, web_stat)
      attrs[:unique_id] = unique_id
      Contents::Tweet.save_form_job(attrs)
    when Sources::WebSite
      attrs = Contents::Web.set_attributes_by_web_stat(object, web_stat)
      attrs[:unique_id] = unique_id
      Contents::Web.save_form_job(attrs)
    end
  rescue Mechanize::RobotsDisallowedError,
          Mechanize::ResponseCodeError => e
    ignore = ::Filters::IgnoreCrawlContent.new
    ignore.exclude_url = url
    ignore.message = e
    ignore.save
  end
end