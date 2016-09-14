class SubjectsController < ApplicationController

  #*********************************************************  

  #include Mongo

  before_action :set_subject                , only:   [:show, :edit, :update, :destroy, :angular, :quizzer]
  before_action :is_first_visit             , only:   [:angular                                 ]
  before_action :set_subject_by_short_name  , only:   [:posts                                   ]
  before_action :is_admin?                  , except: [:search, :search_post, :feed, :show_posts_all, :quizzer, :get_posts, :get_posts_by_chapter, :get_paths, :get_chapters]

  layout "header"                           , only:   [ :show_posts_all, :new ]
  layout "testing"                          , only:   [ :posts, :quizzer      ]

  skip_before_filter :verify_authenticity_token

  #*********************************************************
  # Search by Tags and Context
  #*********************************************************


  def search
    @tags_contexts = Subject.find(params[:id]).tags_contexts.order(points: :desc)
    @subject =  Subject.find(params[:id])

    if request.post?
      @tag = Tag.find(params[:query].to_i);
      @posts = @tag.posts.order(points: :desc)
    end
  end

  #post
  def search_post
    puts "*"*10
    puts "*"*10
    Rails.logger.debug params.inspect
    puts "*"*10
    puts "*"*10
  end


  #*********************************************************
  # Feeds: testing several new feeds
  #*********************************************************

  def feed
    @subject    = Subject.where(id: params[:id]).first
    @posts      = @subject.posts.select([:title, :content_css_classes, :url, :id, :image, :image_style, :details, :points, :background_color]).order(points: :desc).limit(20)

    render "/subjects/feed_v_1", :layout => 'testing'
  end

    
  #*********************************************************
  # Testing
  #*********************************************************

  #get
  #post - file
  def upload_image
    if request.patch?
      uploaded_io = params[:subject][:image]

      puts "*"*10
      puts "*"*10

      @result = Cloudinary::Uploader.upload(uploaded_io)

      puts "*"*10
      puts @result
      puts "*"*10

      #File.open(Rails.root.join('public', uploaded_io.original_filename), 'wb') do |file|
      #file.write(uploaded_io.read)
      @subject = Subject.find(5)
    else
      @subject = Subject.find(5)
    end

    render :layout => 'testing'
  end

  # Subject
  # => recent/top
  # => tags/resources/flow
  def posts
  end




  #*********************************************************

  # Initial Quizzer Step
  def quizzer

    # puts "*"*10 
    # puts "OLD COOKIE: " + cookies[:answers_ids]
    # #answer_ids = [[*1..5].sample, [*6..10].sample, [*11..15].sample]
    # answer_ids = 1
    # cookies[:answers_ids] =  answer_ids.to_json
    # #puts "TYPE: " + cookies[:answers_ids].class.to_s
    # puts "JSON TYPE: " + JSON.parse(cookies[:answers_ids]).class.to_s
    # puts "NEW COOKIE: " + cookies[:answers_ids].to_s
    # puts "*"*10

    cookies[:answers_ids] = []

    if @subject.root_question_id.nil?
      return redirect_to '/w/' + @subject.short_name
    end 

    if user_signed_in?
      userFlows = UserFlow.where(user: current_user, subject: @subject)
      unless userFlows.empty? 
        userFlowId = userFlows.first.flow.id
        return redirect_to '/w/' + @subject.short_name  + '?flow_id=' + userFlowId.to_s
      end
    end

    @subject_id = @subject.id
    @question = Question.find(@subject.root_question_id)
  end

  def angular
     render :layout => false
  end  


  # GET /subjects
  # GET /subjects.json
  def index
    @subjects = Subject.all
  end

  # GET /subjects/1
  # GET /subjects/1.json
  def show
  end


  # json
  def get_posts
    @subject    = Subject.where(id: params[:id]).first
    @posts      = @subject.posts.select([:title, :content_css_classes, :url, :id, :image, :image_style, :details, :points, :background_color]).order(points: :desc)#.limit(20)

    respond_to do |format|
      format.json {render :json => { :posts => @posts, :subject => @subject} }
    end
  end

  def get_posts_by_chapter
    @subject    = Subject.where(id: params[:id]).first
    @chapter    = Chapter.find(params[:chapter_id])
    @posts      = @chapter.posts.select([:title, :content_css_classes, :url, :id, :image, :image_style, :details, :points, :background_color]).order(points: :desc)

    respond_to do |format|
      format.json {render :json => { :posts => @posts, :subject => @subject} }
    end
  end

  def get_paths
    #for now we get subjects instead of paths

    @subjects    = Subject.where(subject_type: "paths")

    puts "*"*10
    puts @subjects.first.inspect
    puts "*"*10
    
    # @subjects.each do |subject|
    #   #todo replace with subject.sample = subject.sample as in O(1) instead of this.
    #   #subject.sample = subject.posts.order(points: :desc).first
    #   subject.instance_eval do
    #     def sample
    #       instance_variable_get("@sample")
    #     end        
    #     def sample=(val) 
    #       instance_variable_set("@sample", 5)
    #     end
    #   end
    # end

    respond_to do |format|
      format.json {render :json => { :posts => @subjects} }
    end
  end

  def get_chapters
    @chapters    = Subject.find(params[:id]).chapters.order(number: :desc)

    respond_to do |format|
      format.json {render :json => @chapters }
    end
  end

  def show_posts_all
    @subject    = Subject.where(short_name: params[:subject_short_name]).first
    @posts      = @subject.posts.order(created_at: :desc).limit(15)
    @chapters   = @subject.chapters.order('created_at')
    @flows      = @subject.flows



    @chapters_resources = @chapters.where(chapter_type: "resource").order(number: :asc)

    if params[:flow_id].nil? || params[:flow_id].empty?
      @chapters_basics = @chapters.where(chapter_type: "basic").order(number: :asc)
    else
      @chapters_basics = Flow.find(params[:flow_id].to_i).chapters
    end 


    posts_ids = @posts.map {|p| p.id}
    #@tags = Post.where(:id => posts_ids).tag_counts

    unless params[:chapter_name].nil? 
      @chapter = Chapter.where(name: params[:chapter_name], subject_id: @subject.id).first
      @posts = @chapter.posts.order(created_at: :desc)
    end 

    unless params[:tag_name].nil?
      @tag = params[:tag_name] 
      @posts = @posts.tagged_with(params.require(:tag_name)).order(created_at: :desc)
    end 
  end

  #*********************************************************
  #          POST : /w/subject     
  #*********************************************************

  def add_post
    if params.has_key?(:flow)
      return create_flow()
    end

    if params.has_key?(:chapter)
      return create_chapter()
    end

    post_params = params.require(:post).permit(:url, :title, :description, :chapter_id, :subject_id, :user_id, :image, :media_type, :minutes)
    #tags = params.require(:tags_list)
    subject = Subject.find(post_params[:subject_id])
    
    post = Post.new(post_params)
      puts "*"*10
      puts URI.parse(post_params[:url]).to_s
      puts "*"*10

    url = URI.parse(post_params[:url])
    if(!url.scheme)
      post.url = "http://" + url.to_s
    elsif(%w{http https}.include?(url.scheme))
      #all good
    else
      puts "************** ERROR with URL"
    end  
      
    # words = post.title.split(/\s+/)
    # tags = words.select {|w| w.match(/^#/) }.map {|w| w[1..-1].downcase }.join(',')
    # post.tag_list = tags

    if !post_params[:chapter_id].empty?
      chapter = Chapter.find(post_params[:chapter_id])
      post.chapter = chapter
    end

    
    session[:return_to] ||= request.referer
    respond_to do |format|
      if post.save
        format.html { redirect_to session.delete(:return_to), notice: 'Subject was successfully created.' }
        format.json { render action: 'show', status: :created, location: @subject }
      else
        #format.html { render action: 'new' }
        #format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_flow
    flow_params = params.require(:flow).permit(:name, :chapters_ids, :subject_id, :user_id)
    subject     = Subject.find(flow_params[:subject_id])
    flow        = Flow.new(flow_params)
    
    session[:return_to] ||= request.referer
    
    respond_to do |format|
      if flow.save
        flow.chapters = Chapter.find(params["flow"]["chapters_ids"])
        if flow.save
          format.html { redirect_to session.delete(:return_to), notice: 'Flow successfully created.' }
          format.json { render action: 'show', status: :created, location: @subject }
        end
      end
    end
  end

    def create_chapter
    chapter_params  = params.require(:chapter).permit(:name, :subject_id, :chapter_type)
    subject         = Subject.find(chapter_params[:subject_id])
    chapter         = Chapter.new(chapter_params)
    
    session[:return_to] ||= request.referer
    
    respond_to do |format|
      if chapter.save
          format.html { redirect_to session.delete(:return_to), notice: 'Chapter successfully created.' }
          format.json { render action: 'show', status: :created, location: @subject }
      end
    end
  end

  # GET /subjects/new
  def new
    @subject = Subject.new
  end

  # GET /subjects/1/edit
  def edit
  end

  # POST /subjects
  # POST /subjects.json
  def create
    @subject = Subject.new(subject_params)
    @subject.short_name = @subject.name.strip.downcase.split(/\s+/).join('')

    respond_to do |format|
      if @subject.save
        format.html { redirect_to '/w/' + @subject.short_name, notice: 'Subject was successfully created.' }
        format.json { render action: 'show', status: :created, location: @subject }
      else
        format.html { render action: 'new' }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subjects/1
  # PATCH/PUT /subjects/1.json
  def update
    respond_to do |format|
      if @subject.update(subject_params)
        format.html { redirect_to @subject, notice: 'Subject was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subjects/1
  # DELETE /subjects/1.json
  def destroy
    @subject.destroy
    respond_to do |format|
      format.html { redirect_to subjects_url }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_subject
      @subject = Subject.find(params[:id])
    end

    def set_subject_by_short_name
      @subject = Subject.where(short_name: params[:subject_short_name]).first
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subject_params
      params.require(:subject).permit(:name, :short_name, :description, :image, :image_css, :subject_type, :root_question_id)
    end

    def is_first_visit
      if current_user.nil?
        return
      end

      mongo_client  = MongoClient.new("localhost", 27017)
      db            = mongo_client.db("wokami")
      collection    = db.collection("is_first_visit")
      doc           = {"user_id" => current_user.id, "is_first_visit" => false, "subject_id" => @subject.id }
      
      is_first = collection.find(doc).to_a.empty?
      # update this at tend of Qs: collection.insert(doc)

      if is_first
        redirect_to "/quizzer/#{@subject.id}"
        return
      end

      return
    end
end
