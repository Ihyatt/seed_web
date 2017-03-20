class API::V1::IncidentsController < API::V1::APIController

  def index
    scope = Incident.search_by( user_id: params[:user_id], 
                                reactions: params[:reactions],
                                tags: params[:tags],
                                ratings: params[:ratings],
                                incident_type_id: params[:incident_type_id],
                                place_id: params[:place_id]
                                )
    @incidents = scope.page(params[:page])
    render_collection(@incidents, scope)
  end

  def show
    @incident = Incident.find params[:id]
    render_resource(@incident)
  end

  def create
    @incident = Incident.new(incident_params)
    if @incident.save
      render_resource(@incident)
    else
      @errors = @incident.errors
      render_errors(@errors, 400)
    end
  end

  def update
    @incident = Incident.find params[:id]
    if @incident.update_attributes(incident_params)
      render_resource(@incident)
    else
      @errors = @incident.errors
      render_errors(@errors, 400)
    end
  end

  private
  def incident_params
    metadata_keys = params[:metadata].keys unless params[:metadata].blank?
    params.permit(:user_id, :slug, :description, :start_time, :location, :reactions_list, :tags_list, :latitude, :longitude, :rating, :completed, :incident_type_id, metadata: metadata_keys)
  end
end