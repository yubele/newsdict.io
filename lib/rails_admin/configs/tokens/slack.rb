RailsAdmin.config do |config|
  config.label_methods << :key
  config.model "Configs::Tokens::Slack" do
    fields :key, :is_default, :token, :channel, :title, :text
  end
end