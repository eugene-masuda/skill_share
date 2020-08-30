FactoryBot.define do
  factory :comment do
    content { "MyText" }
    user { nil }
    order { nil }
  end
end
