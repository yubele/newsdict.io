RailsAdmin.config do |config|
  config.label_methods << :key
  config.model "Configs::Tokens::Slack" do
    fields :key, :token, :channel, :title, :text, :is_default
  end
end