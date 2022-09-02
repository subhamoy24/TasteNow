class Food < ApplicationRecord
  validates :name, presence: true, allow_nil: false
  validates :price, presence: true, numericality: { greater_than: 0 }

  has_many :variations, dependent: :destroy
  has_many :addons, dependent: :destroy
end
