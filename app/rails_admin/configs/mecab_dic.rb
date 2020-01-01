RailsAdmin.config do |config|
  config.model "Configs::MecabDic" do
    field :describe
    field :url, :string
    field :regex_for_ignore_line
    field :regex_for_extract_title
    field :language_code
    field :is_header
  end
end