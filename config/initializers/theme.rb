Rails.configuration.to_prepare do
  Batch.single_server(:theme) do
    Configs::Theme.tidy
  end
  Configs::Theme.apply
end