class MessagesController < ApplicationController

  def index
    @messages = policy_scope(Message).all
  end

end
