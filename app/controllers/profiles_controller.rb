class ProfilesController < InheritedResources::Base
  actions :all, except: [ :index ]
  defaults resource_class: Profile.friendly

  private

    def profile_params
      params.require(:profile).permit(:display_name, :screen_name, :avatar, :available)
    end
end

