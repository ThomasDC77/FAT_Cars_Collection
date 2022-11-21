class Booking < ApplicationRecord
  belongs_to :car
  belongs_to :user
  validates :date, presence: true
end
