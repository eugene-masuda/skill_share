class User < ApplicationRecord
  has_one_attached :avatar
  has_many :gigs
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :full_name, presence: true, length: { maximum: 50 }
end
