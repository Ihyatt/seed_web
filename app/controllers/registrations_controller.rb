class RegistrationsController < Devise::RegistrationsController

  def sign_up_params
    params.require(:user).permit(:email, :password)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :gender_id, :race_id, :email, :password, :birthday)
  end

  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end
end