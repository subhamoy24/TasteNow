class CartItemsController < ApplicationController
  # POST cart_items.json

  def create
    food_id = params[:food_id]
    variation_id = params[:variation_id].present? ? params[:variation_id] : nil
    addon_ids = params[:addon_ids].present? ? Array.wrap(params[:addon_ids]) : []
    addon_ids = addon_ids.map{|id| id.to_i }

    if cart_id = Cart.find_by(user_id: params[:user_id])&.id
      if variation_id.present? && addon_ids.present?
        cart_items = CartItem.where(cart_id: cart_id, variation_id: variation_id).includes(:addons)
        f = 0
        actual_item = nil
        cart_items.each do |cart_item|
          if cart_item.addons.pluck(:id).to_set  == addon_ids.to_set
            f = 1
            actual_item = cart_item
            break          
          end
        end

        if f == 1
          actual_item.update(quantity: actual_item.quantity + 1)
          render json: { cart_item: actual_item.as_json, msg: "CartItem Successfully Updated"}, status: 200
        else
          c = CartItem.create(cart_id: cart_id, variation_id: variation_id, addon_ids: addon_ids, quantity: 1)
          render json: { cart_item: c.as_json, msg: "CartItem Successfully Created" }, status: 200
        end
      elsif variation_id.present?
        cart_item = CartItem.find_by(cart_id: cart_id, variation_id: variation_id)
        if cart_item
          cart_item.update(quantity: cart_item.quantity + 1)
          render json: { cart_item: cart_item.as_json, msg: "CartItem Successfully updated" }, status: 200
        else
          c = CartItem.create(cart_id: cart_id, variation_id: variation_id, quantity: 1)
          render json: { cart_item: c.as_json, msg: "CartItem Successfully Created" }, status: 200
        end      
      elsif food_id.present? && addon_ids.present?
        cart_items = CartItem.where(cart_id: cart_id, food_id: food_id).includes(:addons)
        f = 0
        actual_item = nil

        cart_items.each do |cart_item|
          if cart_item.addons.pluck(:id).to_set  == addon_ids.to_set
            f = 1
            binding.pry
            actual_item = cart_item
            break          
          end
        end

        binding.pry
        if f == 1
          actual_item.update(quantity: actual_item.quantity + 1)
          render json: { cart_item: actual_item.as_json, msg: "CartItem Successfully Updated"}, status: 200
        else
          c = CartItem.create(cart_id: cart_id, food_id: food_id, addon_ids: addon_ids, quantity: 1)
          render json: { cart_item: c.as_json, msg: "CartItem Successfully Created" }, status: 200
        end
      else
        cart_item = CartItem.find_by(cart_id: cart_id, food_id: food_id)
        if cart_item
          cart_item.update(quantity: cart_item.quantity + 1)
          render json: { cart_item: cart_item.as_json, msg: "CartItem Successfully updated" }, status: 200
        else
          c = CartItem.create(cart_id: cart_id, food_id: food_id, quantity: 1)
          render json: { cart_item: c.as_json, msg: "CartItem Successfully Created" }, status: 200
        end
      end
    else
      cart = Cart.create(user_id: params[:user_id])
      c = CartItem.create(cart_id: cart.id, variation_id: variation_id, addon_ids: addon_ids, food_id: food_id, quantity: 1)
      render json: { cart_item: c.as_json, msg: "CartItem Successfully Created" }, status: 200
    end
  end

  def remove
    if params[:cart_item_id].empty?
      render json: { msg: "Cart item must be present" }, status: 402
      return
    else
      if cart_item = CartItem.find_by(id: params[:cart_item_id])
        if cart_item.quantity == 1
          cart_item.destroy
        else
          cart_item.quantity -= 1
          if cart_item.save
            render json: { cart_item: cart_item.as_json, msg: "Cart item Updated Successfully" }, status: 200
          else
            render json: { msg: "Something going wrong" }, status: 500
          end
        end
      else
        render json: { msg: "CartItem Cannot Found" }, status: 404
      end
    end
  end
end
