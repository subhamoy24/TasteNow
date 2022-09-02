class CartItemsAddon < ApplicationRecord
  belongs_to :cart_item
  belongs_to :addon
end
