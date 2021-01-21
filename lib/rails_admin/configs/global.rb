RailsAdmin.config do |config|
  config.model "Configs::Global" do
    include_all_fields
    exclude_fields :_id, :created_at, :updated_at
    field :value, :password
    edit do
      field :key do
        read_only true
      end
    end
    list do
      field :value do
        pretty_value do
          unless bindings[:object].value.empty?
            '*' * 8
          end
        end
      end
      field :enabled, :toggle
    end
  end
end