FactoryBot.define do
  factory :content do
    title { Faker::Lorem.unique.sentence }
    site_name { Faker::Name.unique.name }
    expanded_url { Faker::Internet.unique.url }
    language_code { Faker::Alphanumeric.alphanumeric(number: 2) }
    tags { [Faker::Name.unique.name, Faker::Name.unique.name, Faker::Name.unique.name] }
    created_at { Date.today }
    updated_at { Date.today }
  end
end