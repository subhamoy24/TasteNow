class CartItem < ApplicationRecord

  belongs_to :cart
  belongs_to :variation, optional: true
  belongs_to :food,      optional: true

  has_many :cart_items_addons, dependent: :destroy
  has_many :addons, through: :cart_items_addons

  validates :quantity, numericality: { greater_than: 0 }


  def total_price
    (base_price * quantity).round(2)
  end

  def total_addons_price
    addons.map { |addon| addon.price }.sum
  end

  def base_price
    if variation && addons.present?
      (total_addons_price + variation.price).round(2)
    elsif variation
      variation.price.round(2)
    else
      food.price.round(2)
    end
  end

  def as_json
    super(include: [:cart, :variation, :addons], methods: [:base_price, :total_price])
  end
end
