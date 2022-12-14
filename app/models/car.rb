class Car < ApplicationRecord
  ORIGINS = %w[Française Italienne Japonaise Allemande Américaine]

  belongs_to :user
  has_many :bookings
  has_one_attached :photo

  validates :brand, :model, :year, :price_per_day, :color, :number_street, :name_street, :post_code, :city, presence: true
  validates :origin, inclusion: { in: ORIGINS }

  after_validation :geocode, if: :will_save_change_to_name_street?

  geocoded_by :address

  def address
    "#{number_street} #{name_street} #{post_code} #{city}"
  end
end
