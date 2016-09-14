class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  
  #protect_from_forgery with: :exception

  #http://stackoverflow.com/questions/14734243/rails-csrf-protection-angular-js-protect-from-forgery-makes-me-to-log-out-on
  
  # after_filter :set_csrf_cookie_for_ng

  # def set_csrf_cookie_for_ng
  #   cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  # end

  # protected

  # def verified_request?
  #   super || form_authenticity_token == request.headers['X-XSRF-TOKEN']
  # end


  after_filter :store_location

  def store_location
    # store last url - this is needed for post-login redirect to whatever the user last visited.

      session[:previous_url] = request.referrer
  end

  def after_sign_in_path_for(resource)
    #session[:previous_url] || root_path
    session[:previous_url] || '/'
  end


  #def after_sign_in_path_for(resource)
  #   url_for :controller => '/home', :action => 'featured_subjects' || stored_location_for(resource) || root_path
  #end

  def is_admin?
  	if current_user.nil? || current_user.role != "admin"
    	redirect_to "/"
    end
  end 

  before_filter :configure_devise_params, if: :devise_controller?
  def configure_devise_params
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:name, :email, :password, :password_confirmation, :username)
    end
  end
end
