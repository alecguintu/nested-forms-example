class Vehicle < ActiveRecord::Base
  belongs_to :manufacturer

  validates :name, presence: true
end