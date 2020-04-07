p "Start db:seed"
# Default config
{head: 'Insert this code as high in the <head> tag',
after_body: 'Insert this code immediately after the opening <body> tag',
end_body: 'Insert this code immediately end the closing <body> tag'}.each do |key, value|
  if Configs::View.has_key?(key)
    p "already exits #{key}"
  else

    Configs::View.create!(
      key: key,
      description: value,
      value: String.new
    )
    p "create key #{key}"
  end
end
p "End of db:seed"