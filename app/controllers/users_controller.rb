class UsersController < InheritedResources::Base
  actions :all, except: [ :index ]
  defaults resource_class: User.friendly

  private
  def permitted_params
    params.permit(user: [:screen_name, :user_name])
  end

end
