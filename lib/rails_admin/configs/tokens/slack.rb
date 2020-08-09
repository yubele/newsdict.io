RailsAdmin.config do |config|
  config.label_methods << :key
  config.model "Configs::Tokens::Slack" do
    fields :key, :channel, :username, :text, :webhook
  end
end