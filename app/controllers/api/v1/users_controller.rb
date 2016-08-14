class API::V1::UsersController < API::V1::APIController
  def index
    @users = User.all
    resource = APIResource.new
    resource.status = response.status
    resource.data = @users

    render json: resource
  end

  def show
    @user = User.find params[:id]
    resource = APIResource.new
    resource.status = response.status
    resource.data = @user
    render json: resource
  end
end