class ProfilesController < ApplicationController
  before_action :set_current_profile, only: [:edit, :update]

  def archived
    # for inavailable profile
    @profile = Profile.find(params[:id])
    authorize @profile
    if @profile.available?
      redirect_to @profile
    end
  end

  def show
    # for available profile
    @profile = Profile.friendly.find(params[:screen_name])
    authorize @profile
    if @profile.unavailable?
      redirect_to archived_profile_path(@profile)
    end
  end

  def edit
  end

  def update
    if @profile.update(profile_params)
      redirect_to @profile, notice: t('Profile was successfully updated.')
    else
      render :edit
    end
  end

  private
  def set_current_profile
    @profile = current_user.profile
    authorize @profile
  end

  def profile_params
    params.require(:profile).permit(:display_name, :screen_name, :avatar)
  end
end

