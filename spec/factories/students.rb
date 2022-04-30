FactoryBot.define do
  factory :student do
    name                {"田中"}
    kana_name           {"タナカ"}
    birth_on            { Faker::Date.backward }

  end
end
