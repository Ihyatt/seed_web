class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.is_admin
      @conversations = Conversation.all
    else
      redirect_to new_conversation_path
    end
  end

  def new
    @conversation = Conversation.create_for_customer(current_user)
    Rails.logger.info @conversation.inspect
    redirect_to @conversation
  end

  def show
    @conversation = Conversation.friendly.find(params[:id])
    authorize @conversation
    @message = Message.new
  end

  def destroy
    @conversation = Conversation.friendly.find(params[:id])
    authorize @conversation

    @conversation.destroy
    redirect_to conversations_path
  end


end