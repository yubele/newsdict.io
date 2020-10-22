FactoryBot.define do
  factory "CollectTag" do
    name {Faker::Lorem.sentence}
    length {Faker::Lorem.sentence.length}
    count { rand(0..255) }
  end
end