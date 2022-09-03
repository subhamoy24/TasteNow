class CartsController < ApplicationController
  before_action :set_cart, only: %i[ details destroy ]

  def details
    if @cart
      render json: @cart.as_json, status: 404
    else
      render json: { msg: "Cart not Found" }, status: 404
    end
  end

  # POST /carts or /carts.json
  def create
    @cart = Cart.new(user_id: params[:user_id])

    if @cart.save
      render json: { msg: ["Cart was successfully created." ] }, status: 200
    else
      render json: { msg: @cart.errors }, status: 401
    end
  end

  # DELETE /carts/1 or /carts/1.json
  def destroy
    if @cart.destroy
      render json: { cart: @cart, msg: ["Cart was successfully created." ] }, status: 200
    else
      render json: { msg: @cart.errors }, status: 401
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart
      @cart = Cart.find_by(id: params[:id])
    end

end
