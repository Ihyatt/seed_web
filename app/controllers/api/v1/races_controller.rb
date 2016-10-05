class API::V1::RacesController < API::V1::APIController

  def index
    scope = Race.all
    @races = scope.page(params[:page])
    render_collection(@races, scope)
  end

end