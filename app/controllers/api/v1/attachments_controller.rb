class API::V1::AttachmentsController < API::V1::APIController
  def create
    @attachment = Attachment.new(attachment_params)
    
    if @attachment.save
      render_resource(@attachment)
    else
      @errors = @attachment.errors
      render_errors(@errors, 400)
    end
  end

  private
  def attachment_params
    params.permit(:incident_id, :asset)
  end
end
