module SourceUrlConcern
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
    ::Nokogiri::HTML(Mechanize.new.get(source_url).body)
    .xpath('//a').map {|a| a.attribute('href').value if a.attribute('href') }
    .reject(&:blank?)
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