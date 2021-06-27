FactoryBot.define do
  factory "Sources::TwitterAccount" do
    name { Faker::Alphanumeric.alphanumeric(number: 10, min_alpha: 3) }
    description { Faker::Lorem.sentence }
    user { create :user }
    category { create "Configs::Category" }
    fetch_at { Faker::Time.between_dates(from: Date.today.ago(1.year), to: Date.today, period: :all) }
    icon_blob { Faker::String.random }
    created_at { Faker::Time.between_dates(from: Date.today.ago(1.year), to: Date.today, period: :all) }
    updated_at { Faker::Time.between_dates(from: Date.today.ago(1.year), to: Date.today, period: :all) }
  end
end