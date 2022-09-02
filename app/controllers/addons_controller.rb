class AddonsController < ApplicationController
  before_action :set_addon, only: %i[destroy]

  # POST /addons or /addons.json
  def create
    @addon = Addon.new(addon_params)
    
    if @addon.save  
      render json: { msg: "Addon was successfully created." }, status: 200
    else
      render json: { msg: @addon.errors }, status: 401
    end
  end

  # DELETE /addons/1 or /addons/1.json
  def destroy
    @addon.destroy

    render json: { msg: "Addon was successfully destroyed." }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_addon
      @addon = Addon.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def addon_params
      params.fetch(:addon, {:food_id, :name, :description, :price})
    end
end
