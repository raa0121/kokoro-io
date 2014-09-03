class SessionsController < ApplicationController

  def create
    auth = request.env['omniauth.auth']
    user = User.where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.screen_name = auth.info.name
      user.user_name = User.uniq_user_name auth.info.nickname
      user.avatar_url = auth.info.image
      user.save
    end
    session[:user_id] = user.id
    redirect_to root_path, notice: t('auth.logged_in')
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: t('auth.signed_out')
  end

end
