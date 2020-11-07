FactoryBot.define do
  factory 'Configs::Tokens::Chatwork' do
    _id { BSON::ObjectId.new }
    key { Faker::Name.unique.name }
    created_at { Faker::Time.between_dates(from: Date.today.ago(1.year), to: Date.today, period: :all) }
    updated_at { Faker::Time.between_dates(from: Date.today.ago(1.year), to: Date.today, period: :all) }
    _type { "Configs::Tokens::Chatwork" }
    is_default { [true, false].sample }
    room_id { Faker::Number.between(from: 2, to: 255) }
    text { Faker::Name.unique.name }
    token { Faker::Name.unique.name }
  end
end
