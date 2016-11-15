class AttachmentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @attachments = Attachment.all
  end

  def new
    @incidents = current_user.incidents
    @attachment = Attachment.new
  end

  def create
    @attachment = Attachment.new(attachment_params)
    
    if @attachment.save
      redirect_to @attachment, notice: 'Attachment was successfully created.'
    else
      render :new
    end

  end

  def show
    @attachment = Attachment.find(params[:id])
  end

  private
  def attachment_params
    params.require(:attachment).permit(:incident_id, :asset)
  end
end
