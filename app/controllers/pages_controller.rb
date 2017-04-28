class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index ]
  skip_after_action :verify_authorized, except: :index
  skip_after_action :verify_policy_scoped, only: :index

  def index
    if current_user
      @access_token = current_user.primary_access_token
      render :chat, layout: 'chat'
    else
    end
  end

end
