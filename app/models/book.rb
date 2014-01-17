class Book < ActiveRecord::Base
  has_one :cover, dependent: :destroy

  accepts_nested_attributes_for :cover, allow_destroy: true

  validates :title, presence: true
  validates :cover, associated: true, presence: true
end