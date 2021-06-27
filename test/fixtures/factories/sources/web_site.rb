FactoryBot.define do
  factory 'Sources::WebSite' do
    _id { BSON::ObjectId.new }
    name { Faker::App.name[1..255] }
    description { Faker::App.name[0..255] }
    user { create :user }
    category { create "Configs::Category" }
    fetch_at { Faker::Time.between_dates(from: Date.today.ago(1.year), to: Date.today, period: :all) }
    icon_blob { Faker::String.random }
    created_at { Faker::Time.between_dates(from: Date.today.ago(1.year), to: Date.today, period: :all) }
    updated_at { Faker::Time.between_dates(from: Date.today.ago(1.year), to: Date.today, period: :all) }
    source_url { Faker::Internet.url }
    xpath { "/html/body/div/div" }
  end
end
