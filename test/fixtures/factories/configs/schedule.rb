FactoryBot.define do
  factory "Configs::Schedule" do
    key { Faker::Name.unique.name }
    description { Faker::Name.unique.name }
    hour { rand(1..24) }
    min { rand(1..59) }
    wday { rand(0..6) }
  end
end