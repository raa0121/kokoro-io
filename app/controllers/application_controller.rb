class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  protect_from_forgery with: :exception
  helper_method :current_user
  before_action :detect_locale

  private

  def detect_locale
    if request.headers['Accept-Language']
      I18n.locale = request.headers['Accept-Language'].scan(/^[a-z]{2}/).first
    else
      ENV['DEFAULT_LOCALE'] || 'en'
    end
  end

end
