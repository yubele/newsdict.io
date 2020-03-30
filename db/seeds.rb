p "Start db:seed"
# Default config
Newsdict::Application.config.keys.each do |key, value|
  if Configs::View.has_key?(key)
    p "already exits #{key}"
  else
    Configs::View.create!(
      key: key,
      describe: value,
      value: String.new
    )
    p "create key #{key}"
  end
end
p "End of db:seed"