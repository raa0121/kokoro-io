class PagesController < ApplicationController
  skip_load_and_authorize_resource

  def index
    if current_user
      render :chat, layout: 'chat'
    else
    end
  end

end
