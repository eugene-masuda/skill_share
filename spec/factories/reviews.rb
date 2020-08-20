FactoryBot.define do
  factory :review do
    review { "MyText" }
    stars { 1 }
    order { nil }
    gig { nil }
    buyer { nil }
    seller { nil }
  end
end
