class API::V1::UsersController < API::V1::APIController
  skip_before_action :ensure_api_credentials, only: [:create, :generate]

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

  def generate
    @user = User.generate(params[:facebook_id])
    if @user.save
      render_resource(@user)
    else
      @errors = @user.errors
      render_errors(@errors, 400)
    end
  end

  private
  def user_params
    params.permit(:email, :password, :first_name, :last_name, :race_id, :gender_id, :religion_id, :birthday )
  end
end