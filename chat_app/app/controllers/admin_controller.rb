class AdminController < ApplicationController
	def app
		@conversations = Conversation.where(admin_id: @current_user.id)
  end

  def conversation
  	@conversation = Conversation.find(params[:conversation_id])
  end
end