class Cart < ApplicationRecord
  belongs_to :user

  has_many :cart_items, dependent: :destroy

  def gross_amount
    cart_items.map{ |cart_item| cart_item.total_price }.sum
  end

  def as_json
    super(only: [:id], include: { cart_items: { only: [:id, :quantity], include: { variation: { only: [:id, :price, :name, :description] }, food: { only: [:id, :price, :name, :description] } , addons: { only: [:id, :price, :name, :description] }}, methods: [:total_price, :base_price]}})
  end
end
