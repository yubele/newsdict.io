RailsAdmin.config do |config|
  config.model "Configs::Global" do
    include_all_fields
    exclude_fields :_id, :created_at, :updated_at
  end
end