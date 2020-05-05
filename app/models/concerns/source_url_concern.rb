module SourceUrlConcern
  extend ActiveSupport::Concern

  # Get external urls
  def urls
    ::Nokogiri::HTML(Mechanize.new.get(source_url).body).xpath('//a').map {|a| a.attribute('href').value }.uniq
  end
  
  class_methods do
  end
end