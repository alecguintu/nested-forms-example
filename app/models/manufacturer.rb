class Manufacturer < ActiveRecord::Base
  has_many :vehicles, dependent: :destroy

  accepts_nested_attributes_for :vehicles, allow_destroy: true

  validates :name, presence: true
  # validates :vehicles, associated: true, presence: true, length: { minimum: 2, maximum: 3 }

  validates :vehicles, associated: true, presence: true
  validate :number_of_vehicles_is_within_limit
  def number_of_vehicles_is_within_limit
    errors.add(:vehicles, "must be between 2 and 3") unless self.vehicles.reject(&:marked_for_destruction?).count.between?(2,3)
  end
end