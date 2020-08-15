FactoryBot.define do
  factory :request do
    description { "MyText" }
    title { "MyString" }
    budget { 1 }
    delivery { 1 }
    user { nil }
    category { nil }
  end
end
