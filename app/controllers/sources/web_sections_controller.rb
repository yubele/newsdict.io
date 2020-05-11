class Sources::WebSectionsController < ActionController::Base
  layout "devise"
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
  def show_links(id, xpath)
    ['/aaa',
    '/bbb',
    '/ccc']
  end
end