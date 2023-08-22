FactoryBot.define do
  factory :order_payment do
    user_id { FactoryBot.create(:user).id }
    item_id { FactoryBot.create(:item).id }
    postcode { "#{Faker::Number.number(digits: 3)}-#{Faker::Number.number(digits: 4)}" }
    prefecture_id { Faker::Number.between(from: 1, to: 47) }
    city { Faker::Address.city }
    block { Faker::Address.street_address }
    building { Faker::Address.secondary_address }
    #先頭に0を付与、その後0から始まる10桁の半角数値を生成
    phone_number { "0#{Faker::Number.leading_zero_number(digits: 9)}" }
  end
end