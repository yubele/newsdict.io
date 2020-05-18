FactoryBot.define do
    factory "Configs::Tokens::Twitter" do
        key { "dummy" }
        consumer_key { "dummy" }
        consumer_secret { "dummy" }
        access_token { "dummy" }
        access_secret { "dummy" }
        is_default { true }
    end
end