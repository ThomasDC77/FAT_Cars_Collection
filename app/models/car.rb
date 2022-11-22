class Car < ApplicationRecord
  belongs_to :user
  validates :brand, :year, :price_per_day, :color, :number_street, :name_street, :post_code, :city, presence: true
  has_many :bookings
  has_one_attached :photo
end
