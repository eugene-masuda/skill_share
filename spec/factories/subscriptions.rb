FactoryBot.define do
  factory :subscription do
    plan_id { "MyString" }
    sub_id { "MyString" }
    status { 1 }
    expired_at { "2020-09-03" }
    user { nil }
  end
end
