class API::V1::UsersController < API::V1::APIController
  def index
    @users = User.all
    render json: @users
  end

  def show
    @user = User.find params[:id]
    render json: @user
  end
end