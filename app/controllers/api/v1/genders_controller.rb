class API::V1::GendersController < API::V1::APIController

  def index
    scope = Gender.by_position
    @genders = scope.page(params[:page])
    render_collection(@genders, scope)
  end

end