class API::V1::UsersController < API::V1::APIController

  def index
    scope = User.all
    @users = scope.page(params[:page])

    resource = APIResource.new
    resource.status = response.status
    resource.data = @users
    resource.set_pagination(@users, scope)

    render json: resource
  end

  def show
    @user = User.find params[:id]
    resource = APIResource.new
    resource.status = response.status
    resource.data = @user
    render json: resource
  end

  def create
    @user = User.new(user_params)

    if @user.save
      resource = APIResource.new
      resource.status = response.status
      resource.data = @user
      render json: resource
    else
      @errors = @user.errors
      render_errors(@errors, 400)
    end
  end

  private
  def user_params
    params.permit(:first_name, :last_name, :email, :password)
  end
end