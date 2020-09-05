FactoryBot.define do
  factory "Sources::TwitterAccount" do
    name { Faker::Alphanumeric.alphanumeric(number: 10, min_alpha: 3) }
    description { Faker::Lorem.sentence }
  end
end