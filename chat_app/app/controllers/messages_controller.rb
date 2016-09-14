class MessagesController < ApplicationController
  #before_action :set_message

  def create
  	#conversation_params = {app_id: params[:app_id], client_id: params[:client_id], admin_id: params[:admin_id]}

  	# TODO: "find_or_create(params)"
    
    #@conversation = Conversation.create!(conversation_params) if conversation.nil?
    @conversation = Conversation.find(params[:conversation_id].to_i)
    @message = Message.create! body: params[:message][:body], conversation: @conversation, sender_id: @current_user.id
  end

  def show
  end

  # private
  #   def set_message
  #     @message = Message.find(params[:message_id])
  #   end
end