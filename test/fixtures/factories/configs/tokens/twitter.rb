FactoryBot.define do
    factory "Configs::Tokens::TwitterAccount" do
        key { Faker::Alphanumeric.alphanumeric(number: 5, min_alpha: 5) }
        consumer_key { Faker::Alphanumeric.alphanumeric(number: 5, min_alpha: 5) }
        consumer_secret { Faker::Alphanumeric.alphanumeric(number: 5, min_alpha: 5) }
        access_token { Faker::Alphanumeric.alphanumeric(number: 5, min_alpha: 5) }
        access_secret { Faker::Alphanumeric.alphanumeric(number: 5, min_alpha: 5) }
    end
end