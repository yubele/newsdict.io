RailsAdmin.config do |config|
  config.label_methods << :key
  config.model "Configs::Tokens::Slack" do
    fields :key, :token, :channel, :title, :text, :configs_schedule_id
    edit do
      field :configs_schedule_id do
        inverse_of
      end
    end
  end
end