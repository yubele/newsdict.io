FactoryBot.define do
  factory 'Paper' do
    _id { BSON::ObjectId.new }
    title { Faker::String.random(length: [0, 255]) }
    description { Faker::String.random(length: [0, 255]) }
    content_ids { Faker::Types.rb_array }
    user_id { BSON::ObjectId.new }
  end
end
