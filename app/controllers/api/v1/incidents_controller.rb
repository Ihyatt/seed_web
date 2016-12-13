class API::V1::IncidentsController < API::V1::APIController

  def index
    scope = Incident.all
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
    params.permit(:user_id, :slug, :description, :start_time, :location,:reactions_list, :latitude, :longitude, :rating, :completed, :incident_type_id)
  end
end