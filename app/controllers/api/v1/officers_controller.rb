class API::V1::OfficersController < API::V1::APIController
  def create
    @officer = Officer.new(officer_params)
    
    if @officer.save
      render_resource(@officer)
    else
      @errors = @officer.errors
      render_errors(@errors, 400)
    end
  end

  def update
    @officer = Officer.find params[:id]
    if @officer.update_attributes(officer_params)
      render_resource(@officer)
    else
      @errors = @officer.errors
      render_errors(@errors, 400)
    end
  end

  private
  def officer_params
    params.permit(:incident_id, :name, :description, :badge_number, :race_id, :gender_id, :age_estimate)
  end
end
