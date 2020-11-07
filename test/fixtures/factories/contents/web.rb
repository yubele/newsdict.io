FactoryBot.define do
  factory 'Contents::Web' do
    _id { BSON::ObjectId.new }
    title { Faker::String.random(length: [0, 255]) }
    site_name { Faker::String.random(length: [0, 255]) }
    content { Faker::String.random(length: [0, 255]) }
    expanded_url { Faker::String.random(length: [0, 255]) }
    image_blob { Faker::String.random }
    image_svg { Faker::String.random(length: [0, 255]) }
    tags { Faker::Types.rb_array }
    http_status { Faker::Number.between(from: 0, to: 255) }
    language_code { Faker::String.random(length: [0, 255]) }
    source_id { BSON::ObjectId.new }
    user_id { BSON::ObjectId.new }
    count_of_shared { Faker::Number.between(from: 0, to: 255) }
    unique_id { Faker::String.random(length: [0, 255]) }
    created_at { Faker::Time.between_dates(from: Date.today.ago(1.year), to: Date.today, period: :all) }
    updated_at { Faker::Time.between_dates(from: Date.today.ago(1.year), to: Date.today, period: :all) }
    _type { "Contents::Web" }
  end
end
