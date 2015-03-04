class Oauth::AuthorizationsController < Doorkeeper::AuthorizationsController
  helper_method :current_user
  # load_and_authorize_resource
  before_action :detect_locale
  before_action :authenticate_user

  def current_user
    @current_user ||= User.where(id: session[:user_id]).first if session
  end

  def detect_locale
    if request.headers['Accept-Language']
      I18n.locale = request.headers['Accept-Language'].scan(/^[a-z]{2}/).first
    else
      ENV['DEFAULT_LOCALE'] || 'en'
    end
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


end
