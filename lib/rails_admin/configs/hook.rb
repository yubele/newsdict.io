RailsAdmin.config do |config|
  config.model "Configs::Hook" do
    include_all_fields
    exclude_fields :_id, :created_at, :updated_at
    edit do
      field :key do
        read_only true
      end
    end
  end
end