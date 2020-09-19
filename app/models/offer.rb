class Offer < ApplicationRecord
  belongs_to :request
  belongs_to :user

  enum status: [:保留中, :認証, :拒否]
  validates :amount, :days, numericality: { only_integer: true, message: "must be a number" }
end
