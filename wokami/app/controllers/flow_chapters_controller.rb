class FlowChaptersController < ApplicationController
  before_action :set_flow_chapter, only: [:show, :edit, :update, :destroy]

  # GET /flow_chapters
  # GET /flow_chapters.json
  def index
    @flow_chapters = FlowChapter.all
  end

  # GET /flow_chapters/1
  # GET /flow_chapters/1.json
  def show
  end

  # GET /flow_chapters/new
  def new
    @flow_chapter = FlowChapter.new
  end

  # GET /flow_chapters/1/edit
  def edit
  end

  # POST /flow_chapters
  # POST /flow_chapters.json
  def create
    @flow_chapter = FlowChapter.new(flow_chapter_params)

    respond_to do |format|
      if @flow_chapter.save
        format.html { redirect_to @flow_chapter, notice: 'Flow chapter was successfully created.' }
        format.json { render action: 'show', status: :created, location: @flow_chapter }
      else
        format.html { render action: 'new' }
        format.json { render json: @flow_chapter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /flow_chapters/1
  # PATCH/PUT /flow_chapters/1.json
  def update
    respond_to do |format|
      if @flow_chapter.update(flow_chapter_params)
        format.html { redirect_to @flow_chapter, notice: 'Flow chapter was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @flow_chapter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /flow_chapters/1
  # DELETE /flow_chapters/1.json
  def destroy
    @flow_chapter.destroy
    respond_to do |format|
      format.html { redirect_to flow_chapters_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_flow_chapter
      @flow_chapter = FlowChapter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def flow_chapter_params
      params.require(:flow_chapter).permit(:flow_id, :chapter_id)
    end
end
