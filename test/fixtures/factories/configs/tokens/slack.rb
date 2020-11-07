FactoryBot.define do
  factory 'Configs::Tokens::Slack' do
    _id { BSON::ObjectId.new }
    key { Faker::Name.unique.name }
    created_at { Faker::Time.between_dates(from: Date.today.ago(1.year), to: Date.today, period: :all) }
    updated_at { Faker::Time.between_dates(from: Date.today.ago(1.year), to: Date.today, period: :all) }
    _type { "Configs::Tokens::Slack" }
    is_default { [true, false].sample }
    channel { Faker::Name.unique.name }
    username { Faker::Name.unique.name }
    text { Faker::Name.unique.name }
    webhook { Faker::Name.unique.name }
  end
end
