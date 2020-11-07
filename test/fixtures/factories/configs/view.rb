FactoryBot.define do
  factory 'Configs::View' do
    _id { BSON::ObjectId.new }
    key { Faker::Name.unique.name }
    created_at { Faker::Time.between_dates(from: Date.today.ago(1.year), to: Date.today, period: :all) }
    updated_at { Faker::Time.between_dates(from: Date.today.ago(1.year), to: Date.today, period: :all) }
    _type { "Configs::View" }
    description { Faker::Name.unique.name }
    value { Faker::Name.unique.name }
  end
end
