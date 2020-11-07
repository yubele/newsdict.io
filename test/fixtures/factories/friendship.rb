FactoryBot.define do
  factory 'Friendship' do
    _id { BSON::ObjectId.new }
    friend_user_id { BSON::ObjectId.new }
    status_id { Faker::Number.between(from: 0, to: 255) }
    user_id { BSON::ObjectId.new }
    created_at { Faker::Time.between_dates(from: Date.today.ago(1.year), to: Date.today, period: :all) }
    updated_at { Faker::Time.between_dates(from: Date.today.ago(1.year), to: Date.today, period: :all) }
  end
end
