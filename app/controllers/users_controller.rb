class UsersController < ApplicationController
  before_action :set_user, only: %i[destroy]

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    if @user.save
      render json: { msg: ["user was created successfully"] }, status: 200
    else
      render json: { msg: @user.errors }, status: 401
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    render json: { msg: ["successfully destroyed"] }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :password)
    end
end
