class SessionsController < ApplicationController

  def create
    user = User.from_omniauth request.env['omniauth.auth']
    if user.id || user.save
      session[:user_id] = user.id
      redirect_to root_path, notice: t('auth.signed_in')
    else
      redirect_to root_path, alert: t('auth.failed')
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: t('auth.signed_out')
  end

end
