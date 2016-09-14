class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :edit_lesson]
  before_action :is_admin?, :except => [:vote]

  def new_lesson
    @post = Post.new
    @post.subject = Subject.find(params.require(:subject_id))
    @post.user = current_user
  end

  def edit_lesson
    render "new_lesson.html.erb"
  end

  def vote
    post = Post.find(params.require(:post_id))
    is_vote_up = params.require(:is_vote_up)
    #is_basic_chapter = params.require(:is_basic_chapter)
    
    #puts "********"
    #puts params.require(:is_vote_up) == "true"
    #puts "********"

    p = Points.new

    if params.require(:is_vote_up) == "true"
      #progress arc: points if post belongs to chapter
      if !(current_user.liked? post)
        unless post.chapter.nil?
          result = Points.where(:user => current_user, :chapter => post.chapter)
          if result.empty?
            p = Points.new(:user => current_user, :chapter => post.chapter)
          else
            p = result.first
          end
          p.size += 20;
          p.save
        end

        post.liked_by current_user
      end #progress arc
    else
      post.unliked_by current_user
    end

    chapter_hash = p.chapter.nil? ? {} : { :chapter_id => p.chapter.id } 
    respond_to do |format|      
      format.html { render :json => chapter_hash.merge({:new_score => post.votes.size, :new_points => p.size })}
      format.json { render :json => chapter_hash.merge({:new_score => post.votes.size, :new_points => p.size})}
    end
  end

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    #@post = process_tags(@post)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render action: 'show', status: :created, location: @post }
      else
        format.html { render action: 'new' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    #@post = process_tags(@post)
    @post.save

    respond_to do |format|
      if @post.update(post_params.except(:tags))
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :points, :url, :image, :subject_id, :chapter_id, :description, :media_type, :tag_list, :minutes, :tags)
    end

    # tags processing
    #   tags are in the format: "context/tag, context/tag, ..."
    #   context as in acts_as_taggable gem context
    def process_tags(post)
      tags_text = params[:post][:tags]
      tag_array = tags_text.split(',')
      tag_array.each do |tag|
        tag_with_context = tag.split('/');
        post.set_tag_list_on(tag_with_context[0].strip, tag_with_context[1].strip)
      end
      return post
    end
end
