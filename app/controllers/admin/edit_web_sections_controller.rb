class Admin::EditWebSectionsController < ActionController::Base
  layout "devise"
  # Select section of html
  def show(id)
    agent = Mechanize.new { |_agent| _agent.user_agent = WebStat::Configure.get["user_agent"] }
    @content = agent.get(Base64.decode64(id)).body
  end
  
  def edit(id)
  end
end