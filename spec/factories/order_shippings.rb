FactoryBot.define do
  factory :order_shipping do
    
    token         { "tok_sk39894984938320" }
    postal_code   { "123-4567" }
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    city          { Faker::Address.city }
    address       { Faker::Address.street_address }
    building      { "建物" }
    phone_number  { "0901234567" }

  end
end
