FactoryBot.define do
  factory :order_address do
    user_id { '1' }
    item_id { '1' }
    postal_code { '123-4567' }
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    city { Faker::Address.city }
    block { '１−１' }
    building_name { '東京ハイツ' }
    phone_number { Faker::Number.number(digits: 11) }
  end
end
