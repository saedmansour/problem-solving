class AnswerTagsController < ApplicationController
  before_action :set_answer_tag, only: [:show, :edit, :update, :destroy]
  before_action :is_admin?

  # GET /answer_tags
  # GET /answer_tags.json
  def index
    @answer_tags = AnswerTag.all
  end

  # GET /answer_tags/1
  # GET /answer_tags/1.json
  def show
  end

  # GET /answer_tags/new
  def new
    @answer_tag = AnswerTag.new
  end

  # GET /answer_tags/1/edit
  def edit
  end

  # POST /answer_tags
  # POST /answer_tags.json
  def create
    @answer_tag = AnswerTag.new(answer_tag_params)

    respond_to do |format|
      if @answer_tag.save
        format.html { redirect_to @answer_tag, notice: 'Answer tag was successfully created.' }
        format.json { render action: 'show', status: :created, location: @answer_tag }
      else
        format.html { render action: 'new' }
        format.json { render json: @answer_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /answer_tags/1
  # PATCH/PUT /answer_tags/1.json
  def update
    respond_to do |format|
      if @answer_tag.update(answer_tag_params)
        format.html { redirect_to @answer_tag, notice: 'Answer tag was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @answer_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /answer_tags/1
  # DELETE /answer_tags/1.json
  def destroy
    @answer_tag.destroy
    respond_to do |format|
      format.html { redirect_to answer_tags_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answer_tag
      @answer_tag = AnswerTag.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def answer_tag_params
      params.require(:answer_tag).permit(:answer_id, :tag, :weight)
    end
end
