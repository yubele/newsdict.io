RailsAdmin.config do |config|
  config.model "Configs::MecabDic" do
    field :description
    field :url, :string
    field :regex_for_ignore_line
    field :language_code
    field :is_header
  end
end