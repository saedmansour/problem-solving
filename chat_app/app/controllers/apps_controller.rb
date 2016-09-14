class AppsController < ApplicationController
	def index
		@apps = App.all
  end

  def show
    @app    = App.find(params[:id])
    @admin  = @app.admin
    @client = @current_user
    @conversation = Conversation.find_by(app_id: @app.id, admin_id: @admin.id, client_id: @client.id)

    if @conversation.nil?
    	@conversation = Conversation.create!(app_id: @app.id, admin_id: @admin.id, client_id: @client.id)
    end
  end
end