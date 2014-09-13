class RoomsController < InheritedResources::Base

  defaults resource_class: Room.friendly

  def create
    @room = current_user.rooms.create permitted_params[:room]
    create! do |format|
      format.html { redirect_to rooms_path }
    end
  end

  private
  def permitted_params
    params.permit(room: [:screen_name, :room_name, :private])
  end

end
