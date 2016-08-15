class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @message = Message.new(message_params)
    @message.user = current_user
    @message.platform = "web"
    respond_to do |format|
      if @message.save
        format.html { redirect_to @message.conversation }
        format.json { render :show, status: :created, location: @survey }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end


  # Never trust parameters from the scary internet, only allow the white list through.
  def message_params
    params.require(:message).permit(:text, :conversation_id)
  end

  
end