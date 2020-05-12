module SourceWebSectionConcern
  extend ActiveSupport::Concern

  # Get external urls
  def urls
    uri = URI.parse(source_url)
    if [80, 443].include?(uri.port)
      fqdn = "#{uri.scheme}://#{uri.host}"
    else
      fqdn = "#{uri.scheme}://#{uri.host}:#{uri.port}"
    end
    hrefs = Array.new
    agent = Mechanize.new { |_agent| _agent.user_agent = WebStat::Configure.get["user_agent"] }
    ::Nokogiri::HTML(agent.get(source_url).body)
    .xpath("#{xpath}//a/@href").map {|a| a.value unless a.value.blank? }
    .uniq.each do |href|
      if href.match(Regexp.new("^/"))
        hrefs << "#{fqdn}#{href}"
      elsif href.match(Regexp.new("^\."))
        hrefs << "#{fqdn}/#{href}"
      else
        hrefs << "#{fqdn}#{uri.path}/#{href}"
      end
    end
    hrefs
  end
  class_methods do
  end
end