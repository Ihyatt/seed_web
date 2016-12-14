class API::V1::IncidentTypesController < API::V1::APIController

  def index
    scope = IncidentType.by_position
    @incidents = scope.page(params[:page])
    render_collection(@incidents, scope)
  end

end