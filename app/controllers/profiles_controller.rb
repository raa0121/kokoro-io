class ProfilesController < ApplicationController
  before_action :set_current_profile, only: [:edit, :update]

  def show
    # for archived profile
    @profile = Profile.find(params[:id])
    authorize @profile
    unless @profile.archived?
      redirect_to profile_friendly_path(@profile.screen_name)
    end
  end

  def show_friendly
    # for not archived profile
    @profile = Profile.find_by(screen_name: params[:screen_name])
    authorize @profile
    if @profile.archived?
      redirect_to profile_path(@profile)
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

