class Sources::WebSectionsController < ActionController::Base
  layout "devise"
  # @todo: remove
  skip_before_action :verify_authenticity_token
  
  # Show html
  def show(id)
    @content = Sources::WebSection.find_by(id: id)
    agent = Mechanize.new { |_agent| _agent.user_agent = WebStat::Configure.get["user_agent"] }
    @html = agent.get(@content.source_url).body
  end
  # Select section of html
  def edit(id)
    @id = params[:id]
  end
  # show links
  def show_links(id:, xpath:)
    @web_section = Sources::WebSection.find_by(id: id)
    agent = Mechanize.new { |_agent| _agent.user_agent = WebStat::Configure.get["user_agent"] }
    doc = ::Nokogiri::HTML(agent.get(@web_section.source_url).body)
    render json: doc.xpath("#{xpath}//a/@href").map {|a| a.value}.uniq
  end
end