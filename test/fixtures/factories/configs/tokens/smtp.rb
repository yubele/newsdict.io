FactoryBot.define do
  factory 'Configs::Tokens::Smtp' do
    _id { BSON::ObjectId.new }
    key { Faker::Name.unique.name }
    created_at { Faker::Time.between_dates(from: Date.today.ago(1.year), to: Date.today, period: :all) }
    updated_at { Faker::Time.between_dates(from: Date.today.ago(1.year), to: Date.today, period: :all) }
    _type { "Configs::Tokens::Smtp" }
    is_default { [true, false].sample }
    host { Faker::Name.unique.name }
    port { Faker::Number.between(from: 2, to: 255) }
    domain { Faker::Name.unique.name }
    username { Faker::Name.unique.name }
    password { Faker::Name.unique.name }
    authentication { Faker::Name.unique.name }
    enable_starttls_auto { [true, false].sample }
    sender { Faker::Name.unique.name }
  end
end
