FactoryBot.define do
  factory 'Follower' do
    _id { BSON::ObjectId.new }
    followee_user_id { BSON::ObjectId.new }
    user_id { BSON::ObjectId.new }
    created_at { Faker::Time.between_dates(from: Date.today.ago(1.year), to: Date.today, period: :all) }
    updated_at { Faker::Time.between_dates(from: Date.today.ago(1.year), to: Date.today, period: :all) }
  end
end
