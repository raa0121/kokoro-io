class V1::UsersController < V1::ApplicationController
  include Garage::RestfulActions

  def require_resources
    @resources = User.all
  end

  private
  def permitted_params
    params.permit(user: [:screen_name, :user_name])
  end

end
