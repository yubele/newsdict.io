FactoryBot.define do
  factory :content do
    title { Faker::Lorem.sentence }
    site_name { Faker::Name }
    expanded_url { Faker::Internet.url }
    language_code { Faker::Alphanumeric.alphanumeric(number: 2) }
    tags { ["tag1", "tag2", "tag3"] }
    created_at { Date.today }
    updated_at { Date.today }
  end
end