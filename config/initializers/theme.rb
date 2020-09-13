Batch.onetime(:theme) do
  Configs::Theme.tidy
end
Configs::Theme.apply