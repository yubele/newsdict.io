FactoryBot.define do
  factory "Configs::Schedule" do
    key { Faker::Name.unique.name }
    description { Faker::Name.unique.name }
    hour { rand(0..23) }
    min { rand(0..59) }
    wday { rand(0..6) }
  end
end
