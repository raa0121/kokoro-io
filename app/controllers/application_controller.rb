class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  load_and_authorize_resource
  before_action :detect_locale


  private

  def current_user
    @current_user ||= User.where(id: session[:user_id]).first if session
  end

  def current_resource_owner
    @current_resource_owner ||= User.find(resource_owner_id) if resource_owner_id
  end

  def authenticate_user
    unless current_user
      if params['origin'].blank?
        redirect_to '/auth/github'
      else
        redirect_to '/auth/github?origin=' + params['origin']
      end
    end
  end

  def detect_locale
    if request.headers['Accept-Language']
      I18n.locale = request.headers['Accept-Language'].scan(/^[a-z]{2}/).first
    else
      ENV['DEFAULT_LOCALE'] || 'en'
    end
  end

end
