class V1::MessagesController < V1::ApplicationController
  include Garage::RestfulActions

  def require_resources
    @resources = Messages.all
  end
end
