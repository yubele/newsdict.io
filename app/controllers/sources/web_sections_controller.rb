class Sources::WebSectionsController < ActionController::Base
  layout "devise"
  # @todo: remove
  skip_before_action :verify_authenticity_token
  
  # Select section of html
  def show(id)
    @id = params[:id]
    @web_section = Sources::WebSection.find_by(id: id)
  end
  def edit(id)
    @web_section = Sources::WebSection.find_by(id: params[:id])
    @web_section.xpath = params[:xpath]
    if @web_section.save
      redirect_to '/admin/sources~web_section/'
    else
      redirect_to web_section_path
    end
  end
  # Show html
  def html(id)
    @web_section = Sources::WebSection.find_by(id: id)
    agent = Mechanize.new { |_agent| _agent.user_agent = WebStat::Configure.get["user_agent"] }
    @html = agent.get(@web_section.source_url).body
  end
  # show links
  def show_links(id:, xpath:)
    @web_section = Sources::WebSection.find_by(id: id)
    agent = Mechanize.new { |_agent| _agent.user_agent = WebStat::Configure.get["user_agent"] }
    doc = ::Nokogiri::HTML(agent.get(@web_section.source_url).body)
    render json: doc.xpath("#{xpath}//a/@href").map {|a| a.value unless a.value.blank? }.uniq
  end
end