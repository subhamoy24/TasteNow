class VariationsController < ApplicationController
  before_action :set_variation, only: %i[destroy]

  # POST /variations or /variations.json
  def create
    @variation = Variation.new(variation_params)

    if @variation.save
      render { msg: ["Variation was successfully created."] }, status: 200
    else
      render json: { msg: @variation.errors }, status: 401
    end
  end

  # DELETE /variations/1 or /variations/1.json
  def destroy
    @variation.destroy

    render json: { msg: "Variation was successfully destroyed." }, status: 200    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_variation
      @variation = Variation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def variation_params
      params.fetch(:variation, {:food_id, :name, :price, :description})
    end
end
