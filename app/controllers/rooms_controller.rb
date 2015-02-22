class RoomsController < InheritedResources::Base

  defaults resource_class: Room.friendly
  before_action :authenticate_user

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

  def join
    room = Room.where(screen_name: params[:screen_name]).limit(1).first
    if room
      room.users << current_user
      room.save
      redirect_to room_path(room), notice: t('notice.rooms.joined')
    else
      redirect_to :back, alert: t('alert.rooms.not_exist')
    end
  end

  def leave
    room = Room.where(screen_name: params[:screen_name]).limit(1).first
    if room
      room.users.delete current_user
      room.save
      redirect_to room_path(room), notice: t('notice.rooms.leaved')
    else
      redirect_to :back, alert: t('alert.rooms.not_exist')
    end
  end

  private
  def permitted_params
    params.permit(room: [:screen_name, :room_name, :description, :private])
  end

end
