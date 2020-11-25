Configs::View::KEYS.each do |key, value|
  if Configs::View.has_key?(key)
  else
    Configs::View.create!(
      key: key,
      description: value,
      value: String.new
    )
  end
end