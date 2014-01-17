class Cover < ActiveRecord::Base
  belongs_to :book

  validates :color, presence: true
end