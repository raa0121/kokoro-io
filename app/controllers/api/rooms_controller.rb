class Api::RoomsController < Api::ApplicationController
  include Garage::RestfulActions

  private
  def require_resources
    @resources = Room.all
  end

end
