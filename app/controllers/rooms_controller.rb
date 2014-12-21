class RoomsController < InheritedResources::Base

  defaults resource_class: Room.friendly

  def create
    @room = current_user.rooms.create permitted_params[:room]
    membership = @room.memberships.first
    membership.administer! if membership
    create! do |success, failure|
      success.html { redirect_to room_path(@room), notice: t('rooms.created') }
    end
  end

  def index
    @rooms = Room.public_rooms
  end

  private
  def permitted_params
    params.permit(room: [:screen_name, :room_name, :description, :private])
  end

end
