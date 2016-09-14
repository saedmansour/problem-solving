class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :is_admin?, :only => [:index, :show, :edit, :update, :destroy, :new]
          

  #include Mongo

  include Gps

  #*********************************************************
  def next_question

    answer_id = params[:answer_id]
    @is_last_question = false
    @question = next_question_helper(params[:subject_id], params[:question_id], answer_id)

    #Update Answer Path
    if !answer_id.nil?
      cookies[:answers_ids] += ",#{answer_id}"
    end

    @subject_id = params[:subject_id]
    
    #Quizzer Finished: calculate route
    if @question.nil?
      answers_ids_array = cookies[:answers_ids].split(%r{,\s*}).drop(1) #drop(1) because ",first_id,..."
      #@paths = get_user_recommended_paths(params[:subject_id])
      @flow = get_user_recommended_flows(params[:subject_id]).first
      @subject = Subject.find(@subject_id)

      #Save User Flow to avoid repeating the Q&A.
      if !@flow.nil? && user_signed_in?
        puts "WokamiLog: User Signed in"
        userFlow = UserFlow.new(user: current_user, flow: @flow, subject: @subject)
        userFlow.save
      end

      #return render :text => "Calculating learning route: "
      #return render "/posts/gps_results", :layout => nil
      if @flow.nil?
        return redirect_to '/w/' + Subject.find(@subject_id).short_name
      end
      return redirect_to '/w/' + Subject.find(@subject_id).short_name + '?flow_id=' + @flow.id.to_s
    end

    #update answer of user
    render "/subjects/quizzer", :layout => 'testing'
  end

  def next_question_helper(subject_id, prev_question_id, answer_id)
    #initiate Q&A 
    if prev_question_id.nil?
      return Question.find(Subject.find(subject_id).root_question_id)
    end

    next_question = Answer.find(answer_id).next_question_id
    
    # mongo_client  = MongoClient.new("localhost", 27017)
    # db            = mongo_client.db("wokami")
    # collection    = db.collection("users_answers")
    # doc           = {"user_id" => current_user.id, "answer_id" => answer_id }
    # is_empty      = collection.find(doc).to_a.empty?

    # if is_empty
    #   collection.insert(doc)
    # end


    if next_question.nil?
      return nil
    end
    
    return Question.find(next_question)
  end

  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.all
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)

    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
        format.json { render action: 'show', status: :created, location: @question }
      else
        format.html { render action: 'new' }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params[:question].permit(:subject_id, :weight, :content, :is_multi)
    end
end
