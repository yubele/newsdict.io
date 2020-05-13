class Sources::WebSitesController < ActionController::Base
  layout "devise"
  # @todo: remove
  skip_before_action :verify_authenticity_token
  
  # Select section of html
  def show(id)
    @id = params[:id]
    @web_site = Sources::WebSite.find_by(id: id)
  end
  def edit(id)
    @web_site = Sources::WebSite.find_by(id: params[:id])
    @web_site.xpath = params[:xpath]
    @web_site.save
    redirect_to web_site_path
  end
  # Show html
  def html(id)
    @web_site = Sources::WebSite.find_by(id: id)
    agent = Mechanize.new { |_agent| _agent.user_agent = WebStat::Configure.get["user_agent"] }
    doc = ::Nokogiri::HTML(agent.get(@web_site.source_url).body)
    doc.xpath("//link").each do |link|
      if link.attribute("href")
        href = link.attribute("href").value
        link.set_attribute("href", ApplicationHelper.create_full_url(@web_site.source_url, href))
      end
    end
    doc.xpath("//script").each do |link|
      if link.attribute("src")
        href = link.attribute("src").value
        link.set_attribute("src", ApplicationHelper.create_full_url(@web_site.source_url, href))
      end
    end
    doc.xpath("//img").each do |link|
      if link.attribute("src")
        href = link.attribute("src").value
        link.set_attribute("src", ApplicationHelper.create_full_url(@web_site.source_url, href))
      end
    end
    @html = doc.at('html')
    render layout: nil
  end
  # show links
  def show_links(id:, xpath:)
    @web_site = Sources::WebSite.find_by(id: id)
    agent = Mechanize.new { |_agent| _agent.user_agent = WebStat::Configure.get["user_agent"] }
    doc = ::Nokogiri::HTML(agent.get(@web_site.source_url).body)
    render json: doc.xpath("#{xpath}//a/@href").map {|a| a.value unless a.value.blank? }.uniq
  end
end