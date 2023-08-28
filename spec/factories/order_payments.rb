FactoryBot.define do
  factory :order_payment do
    user_id { FactoryBot.create(:user).id }
    item_id { FactoryBot.create(:item).id }
    postcode { "#{Faker::Number.number(digits: 3)}-#{Faker::Number.number(digits: 4)}" }
    prefecture_id { Faker::Number.between(from: 1, to: 47) }
    city { Faker::Address.city }
    block { Faker::Address.street_address }
    building { Faker::Address.secondary_address }
    phone_number { Faker::Number.decimal_part(digits: 11) }
    #tokenのテストを追加
    token { Faker::Internet.password(min_length: 20, max_length: 30) }
  end
end