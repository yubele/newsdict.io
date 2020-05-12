module SourceWebSectionConcern
  extend ActiveSupport::Concern

  # Get external urls
  def urls
    agent = Mechanize.new { |_agent| _agent.user_agent = WebStat::Configure.get["user_agent"] }
    ::Nokogiri::HTML(agent.get(source_url).body).xpath("#{xpath}//a/@href").map {|a| a.value unless a.value.blank? }.uniq
  end
  class_methods do
  end
end