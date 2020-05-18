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
    p "Insert #{key}."
  end
end
# Default User
unless User.where(email: ENV['ADMIN_USER_EMAIL']).exists?
  user = User.new
  user.email = ENV['ADMIN_USER_EMAIL']
  user.username = "admin"
  user.password = ENV['ADMIN_DEFALT_PASSWORD']
  user.password_confirmation = ENV['ADMIN_DEFALT_PASSWORD']
  user.confirmed_at = Time.now
  user.save!
end
p "End of db:seed"