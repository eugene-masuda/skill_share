FactoryBot.define do
  factory :transaction do
    status { 1 }
    transaction_type { 1 }
    amount { 1.5 }
    source_type { 1 }
  end
end
