class Api::UsersController < Api::ApplicationController
  include Garage::RestfulActions

  private
  def require_resources
    @resources = User.all
  end

end
