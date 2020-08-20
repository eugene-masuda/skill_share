FactoryBot.define do
  factory :offer do
    note { "MyText" }
    amount { 1 }
    days { 1 }
    status { 1 }
    request { nil }
    user { nil }
  end
end
