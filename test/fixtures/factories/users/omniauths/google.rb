FactoryBot.define do
  factory 'Users::Omniauths::Google' do
    _id { BSON::ObjectId.new }
    username { Faker::String.random(length: [0, 255]) }
    email { Faker::String.random(length: [0, 255]) }
    encrypted_password { Faker::String.random(length: [0, 255]) }
    reset_password_token { Faker::String.random(length: [0, 255]) }
    reset_password_sent_at { Faker::Time.between_dates(from: Date.today.ago(1.year), to: Date.today, period: :all) }
    remember_created_at { Faker::Time.between_dates(from: Date.today.ago(1.year), to: Date.today, period: :all) }
    sign_in_count { Faker::Number.between(from: 0, to: 255) }
    current_sign_in_at { Faker::Time.between_dates(from: Date.today.ago(1.year), to: Date.today, period: :all) }
    last_sign_in_at { Faker::Time.between_dates(from: Date.today.ago(1.year), to: Date.today, period: :all) }
    current_sign_in_ip { Faker::String.random(length: [0, 255]) }
    last_sign_in_ip { Faker::String.random(length: [0, 255]) }
    confirmation_token { Faker::String.random(length: [0, 255]) }
    confirmed_at { Faker::Time.between_dates(from: Date.today.ago(1.year), to: Date.today, period: :all) }
    confirmation_sent_at { Faker::Time.between_dates(from: Date.today.ago(1.year), to: Date.today, period: :all) }
    unconfirmed_email { Faker::String.random(length: [0, 255]) }
    failed_attempts { Faker::Number.between(from: 0, to: 255) }
    unlock_token { Faker::String.random(length: [0, 255]) }
    locked_at { Faker::Time.between_dates(from: Date.today.ago(1.year), to: Date.today, period: :all) }
    is_manual_locked { [true, false].sample }
    created_at { Faker::Time.between_dates(from: Date.today.ago(1.year), to: Date.today, period: :all) }
    updated_at { Faker::Time.between_dates(from: Date.today.ago(1.year), to: Date.today, period: :all) }
    _type { "Users::Omniauths::Google" }
    provider { Faker::String.random(length: [0, 255]) }
    uid { Faker::String.random(length: [0, 255]) }
    image { Faker::String.random(length: [0, 255]) }
    provider_email { Faker::String.random(length: [0, 255]) }
  end
end
