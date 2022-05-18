FactoryBot.define do
  factory :lesson do
    name {Faker::Lorem.words(number: 4)}
  end
end
