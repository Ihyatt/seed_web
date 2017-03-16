class API::V1::PlacesController < API::V1::APIController

  def index
    scope = Place.all
    if params[:name]
      scope = scope.search_by_name(params[:name])
    end

    if params[:level]
      scope = scope.with_level(params[:level])
    end

    @places = scope.page(params[:page])
    render_collection(@places, scope)
  end

end