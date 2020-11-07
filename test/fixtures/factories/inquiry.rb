FactoryBot.define do
  factory 'Inquiry' do
    _id { BSON::ObjectId.new }
    name { Faker::String.random(length: [0, 255]) }
    mailaddress { Faker::String.random(length: [0, 255]) }
    url { Faker::String.random(length: [0, 255]) }
    inquiry { Faker::String.random(length: [0, 255]) }
    created_at { Faker::Time.between_dates(from: Date.today.ago(1.year), to: Date.today, period: :all) }
    updated_at { Faker::Time.between_dates(from: Date.today.ago(1.year), to: Date.today, period: :all) }
  end
end
