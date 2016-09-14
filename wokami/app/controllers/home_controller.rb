class HomeController < ApplicationController
  def index
  	render :layout => "simple.html.erb"
  end

  def featured_subjects
  	@subjects = Subject.all.order(updated_at: :desc)
  	#@featured_subjects = @subjects.select { |s| s.subject_type == "featured" }
    @featured_subjects = @subjects.select { |s| s.subject_type == "featured" }
  	@other_subjects = @subjects.select { |s| s.subject_type == "other" || s.subject_type.nil? }
  end

  def tryout
    subject   = Subject.find(5)
    @flows    = subject.flows

  	render :layout => false;
  end

  def landing_page
    render :layout => false;
  end

  def homepage_we_moved
    render :layout => false;
  end
end
