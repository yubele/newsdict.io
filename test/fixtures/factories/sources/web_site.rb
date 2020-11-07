FactoryBot.define do
  factory 'Sources::WebSite' do
    _id { BSON::ObjectId.new }
    name { Faker::String.random(length: [0, 255]) }
    description { Faker::String.random(length: [0, 255]) }
    user_id { BSON::ObjectId.new }
    category_id { BSON::ObjectId.new }
    fetch_at { Faker::Time.between_dates(from: Date.today.ago(1.year), to: Date.today, period: :all) }
    icon_blob { Faker::String.random }
    created_at { Faker::Time.between_dates(from: Date.today.ago(1.year), to: Date.today, period: :all) }
    updated_at { Faker::Time.between_dates(from: Date.today.ago(1.year), to: Date.today, period: :all) }
    _type { "Sources::WebSite" }
    source_url { Faker::String.random(length: [0, 255]) }
    xpath { Faker::String.random(length: [0, 255]) }
  end
end
