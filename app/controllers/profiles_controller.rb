class ProfilesController < InheritedResources::Base

  private

    def profile_params
      params.require(:profile).permit(:display_name, :screen_name, :avatar_id, :available)
    end
end

