p "Start db:seed"
# Default config
Newsdict::Application.config.keys.each do |key, value|
  if Config.where({key: key}).exists
    p "already exits #{key}"
  else
    Config.create!(
      key: key,
      describe: value
    )
    p "create key #{key}"
  end
end
p "End of db:seed"