class Variation < ApplicationRecord
  validates :name, presence: true, allow_nil: false
  validates :price, numericality: { greater_than: 0 }, presence: true
  belongs_to :food
end
