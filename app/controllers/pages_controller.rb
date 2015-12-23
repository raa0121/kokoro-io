class PagesController < ApplicationController

  def index
    if current_user
      render :chat, layout: 'chat'
    else
    end
  end

end
