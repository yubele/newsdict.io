FactoryBot.define do
  factory 'Configs::MecabDic' do
    _id { BSON::ObjectId.new }
    key { Faker::Name.unique.name }
    created_at { Faker::Time.between_dates(from: Date.today.ago(1.year), to: Date.today, period: :all) }
    updated_at { Faker::Time.between_dates(from: Date.today.ago(1.year), to: Date.today, period: :all) }
    _type { "Configs::MecabDic" }
    description { Faker::Name.unique.name }
    url { Faker::Name.unique.name }
    regex_for_ignore_line { Faker::Name.unique.name }
    language_code { Faker::Name.unique.name }
    is_header { [true, false].sample }
  end
end
