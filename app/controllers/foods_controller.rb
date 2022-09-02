class FoodsController < ApplicationController
  before_action :set_food, only: %i[destroy]

  # POST /foods or /foods.json
  def create
    @food = Food.new(food_params)

    if @food.save  
      render json: { msg: ["Food was created successfully"] }, status: 200
    else
      render json:{ msg: @food.errors, status: 401 }     
    end
  end

  # DELETE /foods/1 or /foods/1.json
  def destroy
    @food.destroy

    render json: { msg: ["Food was successfully destroyed."] }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_food
      @food = Food.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def food_params
      params.fetch(:food, { :name, :description })
    end
end
