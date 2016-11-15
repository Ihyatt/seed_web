class API::V1::ReligionsController < API::V1::APIController

  def index
    scope = Religion.by_position
    @religions = scope.page(params[:page])
    render_collection(@religions, scope)
  end

end