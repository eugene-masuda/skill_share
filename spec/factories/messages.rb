FactoryBot.define do
  factory :message do
    content { "MyText" }
    user { nil }
    conversation { nil }
  end
end
