FactoryBot.define do
  factory :gig do
    title { "MyString" }
    video { "MyString" }
    active { false }
    has_single_pricing { false }
    user { nil }
    category { nil }
  end
end
