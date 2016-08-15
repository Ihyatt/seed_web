class API::V1::APIController < ActionController::API
  before_action :ensure_api_credentials
  rescue_from ActiveRecord::RecordNotFound, :with => :catch_404

  def catch_404(exception)
    render_error(exception.message, 404)
  end  

  def ensure_api_credentials
    get_write_key
    api_key = APIKey.where(write_key: params[:write_key])
    if !api_key.exists?
      render_error("Invalid Write Key", 403)
    end
  end

  def get_write_key
    if write_key = params[:write_key].blank? && request.headers["X-AUTH-WRITEKEY"]
      params[:write_key] = write_key
    end
  end

  def render_collection(collection, scope)
    render json: collection, adapter: :json, root: :data, meta: {status: response.status, pagination: set_pagination(collection,scope)}
  end

  def render_resource(resource)
    render json: resource, adapter: :json, root: :data, meta: {status: response.status}
  end

  def set_pagination(items,scope)
    pagination = {
      page: items.current_page, 
      total_pages: items.total_pages,
      count: scope.size
    }
    return pagination
  end

  def render_error(message, status)
    render json: { success: false, status: status, errors: [ message: message ]}
  end

  def render_errors(errors, status)
    output = []
    errors.to_hash(true).each do |key, value|
      output << {
        message: value.first,
        field: key.to_s
      }
    end
    
    render json: { success: false, status: status, errors: output }, status: status
  end
end