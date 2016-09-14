class NewsController < ApplicationController  
	before_filter :authenticate_user!

  def index
  	authorize News

    @news = News.all
    render json: @news
  end

  def show
    @news = News.find(params[:id])
    authorize @news
    render json: @news
  end
  
end
