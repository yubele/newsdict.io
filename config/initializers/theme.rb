Batch.single_server(:theme) do
  Configs::Theme.tidy
end
Configs::Theme.apply