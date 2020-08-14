FactoryBot.define do
  factory :order do
    due_date { "2020-08-14" }
    title { "MyString" }
    amount { 1.5 }
    status { 1 }
    seller_name { "MyString" }
    buyer_name { "MyString" }
    gig { "" }
    buyer { "" }
    seller { "" }
  end
end
