RailsAdmin.config do |config|
  config.model Page do
    edit do
      include_all_fields
      field :content, :ck_editor
    end
  end
end