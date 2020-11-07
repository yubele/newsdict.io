FactoryBot.define do
  factory 'Configs::Hook' do
    _id { BSON::ObjectId.new }
    key { Faker::Name.unique.name }
    created_at { Faker::Time.between_dates(from: Date.today.ago(1.year), to: Date.today, period: :all) }
    updated_at { Faker::Time.between_dates(from: Date.today.ago(1.year), to: Date.today, period: :all) }
    _type { "Configs::Hook" }
    notify_chatwork_id { BSON::ObjectId.new }
    notify_slack_id { BSON::ObjectId.new }
  end
end
