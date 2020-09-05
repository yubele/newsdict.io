FactoryBot.define do
  factory "Configs::Category" do
    key { Faker::Name.unique.name }
  end
end