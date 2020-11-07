FactoryBot.define do
  factory 'Configs::Theme' do
    _id { BSON::ObjectId.new }
    key { Faker::Name.unique.name }
    created_at { Faker::Time.between_dates(from: Date.today.ago(1.year), to: Date.today, period: :all) }
    updated_at { Faker::Time.between_dates(from: Date.today.ago(1.year), to: Date.today, period: :all) }
    _type { "Configs::Theme" }
    description { Faker::Name.unique.name }
    is_active { [true, false].sample }
  end
end
