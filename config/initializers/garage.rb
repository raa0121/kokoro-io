# -*- coding: utf-8 -*-

Garage.configure {}
Garage::TokenScope.configure {}

Doorkeeper.configure do
  orm :active_record
  default_scopes :public
  optional_scopes(*Garage::TokenScope.optional_scopes)
  enable_application_owner confirmation: true, presence: true

  resource_owner_from_credentials do |routes|
    User.find_by(screen_name: params[:screen_name])
  end
  resource_owner_authenticator do
    User.where(id: session[:user_id]).first || redirect_to(login_url)
  end
end
