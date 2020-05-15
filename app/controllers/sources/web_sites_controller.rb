class Sources::WebSitesController < ActionController::Base
  layout "devise"
  
  # Select section of html
  # @param [String] id
  def edit(id)
    @id = params[:id]
    @web_site = Sources::WebSite.find_by(id: id)
  end
  # Save xpath
  # @param [String] id
  def update(id)
    web_site = params[:sources_web_site].permit(:id, :name, :source_url, :xpath)
    @web_site = Sources::WebSite.find_by(id: params[:id])
    @web_site.update_attributes(web_site)
    unless request.patch?
      redirect_to '/admin/sources~web_site/'
    end
  end
  # Show html
  # @param [String] id
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
end