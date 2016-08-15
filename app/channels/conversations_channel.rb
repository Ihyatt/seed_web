class ConversationsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "conversations_#{params['conversation_id']}_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def send_message(data)
    Rails.logger.info "send_message  #{data}"
    # {"message"=>"test", "conversation_id"=>4, "action"=>"send_message"}
    message = Message.new
    message.text = data["message"]
    message.conversation_id = data["conversation_id"]
    message.platform = "web"
    message.user = current_user
    message.save
    
    puts message.inst
    
  end
end