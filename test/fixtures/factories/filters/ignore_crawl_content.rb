FactoryBot.define do
  factory 'Filters::IgnoreCrawlContent' do
    _id { BSON::ObjectId.new }
    created_at { Faker::Time.between_dates(from: Date.today.ago(1.year), to: Date.today, period: :all) }
    updated_at { Faker::Time.between_dates(from: Date.today.ago(1.year), to: Date.today, period: :all) }
    _type { "Filters::IgnoreCrawlContent" }
    exclude_url { Faker::String.random(length: [0, 255]) }
    message { Faker::String.random(length: [0, 255]) }
  end
end
