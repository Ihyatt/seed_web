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
    set_incident
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
    set_incident
    if @incident.update_attributes(incident_params)
      render_resource(@incident)
    else
      @errors = @incident.errors
      render_errors(@errors, 400)
    end
  end

  private
  def set_incident
    @incident = Incident.friendly.find(params[:id])
  end

  def incident_params
    params.permit(:user_id, :slug, :description, :start_time, :location,:reactions_list, :tags_list, :latitude, :longitude, :rating, :completed, :incident_type_id, :incident_type_name, :metadata)
  end
end