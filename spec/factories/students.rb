FactoryBot.define do
  factory :student do
    name                  {"松本"}
    kana_name             {"マツモト"}
    birth_on              {Faker::Date.between(from: 5.days.ago, to: Date.today)}
  end
end