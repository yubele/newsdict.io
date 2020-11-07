FactoryBot.define do
  factory 'Post' do
    _id { BSON::ObjectId.new }
    created_at { Faker::Time.between_dates(from: Date.today.ago(1.year), to: Date.today, period: :all) }
    updated_at { Faker::Time.between_dates(from: Date.today.ago(1.year), to: Date.today, period: :all) }
    name { Faker::String.random(length: [0, 255]) }
    body { Faker::String.random(length: [0, 255]) }
    hook_id { BSON::ObjectId.new }
    schedule_id { BSON::ObjectId.new }
    _type { "Post" }
  end
end
