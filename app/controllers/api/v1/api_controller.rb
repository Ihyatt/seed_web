class API::V1::APIController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, :with => :catch_404

  def catch_404(exception)
    render_error(exception.message, 404)
  end  

  def render_error(message, status)
    render json: { success: false, status: status, errors: [ message: message ]}
  end
end