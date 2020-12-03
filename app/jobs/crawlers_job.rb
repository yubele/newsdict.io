class CrawlersJob < ApplicationJob
  queue_as :crawlers
  # Fetch the web pages by url
  # @param [Source] object
  # @param [String] url
  # @param [Mixed] unique_id
  # @param [String] shared_text
  def perform(object, url:, unique_id: nil, shared_text: nil)
    web_stat = WebStat.stat_by_url(url, userdics: Configs::MecabDic.userdics )
    case(object.class)
    when Sources::TwitterAccount, Sources::Relations::TwitterAccount
      model = Contents::Tweet
    when Sources::WebSite
      model = Contents::Web
    end
    attrs = model.set_attributes_by_web_stat(object, web_stat)
    attrs[:unique_id] = unique_id
    attrs[:shared_text] = shared_text
    model.save_form_job(attrs)
  rescue Mechanize::RobotsDisallowedError,
          Mechanize::ResponseCodeError => e
    ignore = ::Filters::IgnoreCrawlContent.new
    ignore.exclude_url = url
    ignore.message = e
    ignore.save
  end
end