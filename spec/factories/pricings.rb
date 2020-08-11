FactoryBot.define do
  factory :pricing do
    title { "MyString" }
    description { "MyText" }
    delivery_time { 1 }
    price { 1 }
    pricing_type { 1 }
    gig { nil }
  end
end
