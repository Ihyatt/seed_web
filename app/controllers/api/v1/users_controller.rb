class API::V1::UsersController < API::V1::APIController

  def index
    scope = User.all
    @users = scope.page(params[:page])
    render_collection(@users, scope)
  end

  def show
    @user = User.find params[:id]
    render_resource(@user)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render_resource(@user)
    else
      @errors = @user.errors
      render_errors(@errors, 400)
    end
  end

  def update
    @user = User.find params[:id]
    if @user.update_attributes(user_params)
      render_resource(@user)
    else
      @errors = @user.errors
      render_errors(@errors, 400)
    end
  end

  private
  def user_params
    params.permit(:email, :password, :first_name, :last_name )
  end
end