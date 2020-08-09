RailsAdmin.config do |config|
  config.label_methods << :key
  config.model "Configs::Tokens::Chatwork" do
    fields :key, :token, :room_id, :text
  end
end