FactoryBot.define do
  factory 'Source' do
    _id { BSON::ObjectId.new }
    name { Faker::String.random(length: [0, 255]) }
    description { Faker::String.random(length: [0, 255]) }
    user { create :user }
    category { create "Configs::Category" }
    fetch_at { Faker::Time.between_dates(from: Date.today.ago(1.year), to: Date.today, period: :all) }
    icon_blob { Faker::String.random }
    created_at { Faker::Time.between_dates(from: Date.today.ago(1.year), to: Date.today, period: :all) }
    updated_at { Faker::Time.between_dates(from: Date.today.ago(1.year), to: Date.today, period: :all) }
  end
end
