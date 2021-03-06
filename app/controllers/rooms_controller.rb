class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy]
  before_action :set_room_by_screen_name, only: [:show_friendly]

  def create
    @room = Room.new(room_params)
    @room.memberships.build(
      memberable: current_user,
      authority: :administrator
    )
    authorize @room

    # FIXME: error handling
    if @room.save
      redirect_to(room_path(@room), notice: t('rooms.created'))
    else
      render :new
    end
  end

  def new
    @room = Room.new
    authorize @room
  end

  def show_friendly
    if @room.archived?
      redirect_to room_path(@room)
    end
    render action: :show
  end

  def show
    unless @room.archived?
      redirect_to room_friendly_path(@room.screen_name)
    end
  end

  def index
    @rooms = policy_scope(Room).public_rooms
  end

  def edit
  end

  def update
    if @room.update(room_params)
      redirect_to @room, notice: t('Room was successfully updated.')
    else
      render :edit
    end
  end

  def destroy
    authorize @room
  end

  def join
    room = Room.find(params[:id])
    return redirect_to :back, alert: t('alert.rooms.not_exist') unless room
    return redirect_to :back, alert: t('alert.rooms.not_joinbale') unless room.joinable? current_user
    authorize room

    if room.users.include? current_user
      room.memberships.find_by(memberable: current_user)&.member!
    else
      room.users << current_user
      room.save
    end
    redirect_to room_path(room), notice: t('notice.rooms.joined')
  end

  def leave
    room = Room.find(params[:id])
    return redirect_to :back, alert: t('alert.rooms.not_exist') unless room
    return redirect_to :back, alert: t('alert.rooms.not_leaveable') unless room.leaveable? current_user
    authorize room

    room.users.delete current_user
    room.save
    return redirect_to room_path(room), notice: t('notice.rooms.leaved') if room.public?
    return redirect_to rooms_path, notice: t('notice.rooms.leaved') if room.private?
  end

  def invite
    room = Room.find(params[:id])
    return redirect_to :back, alert: t('alert.rooms.not_exist') unless room
    return redirect_to :back, alert: t('alert.rooms.not_invitable') unless room.invitable? current_user
    authorize room

    user_to_invite = Profile.find_by(screen_name: params[:invitation][:screen_name])&.user
    return redirect_to :back, alert: t('alert.users.not_exist') unless user_to_invite

    if room.users.include? user_to_invite
      membership = room.memberships.find_by(memberable: user_to_invite)
      # Already have membership
      if membership.administrator? || membership.maintainer? || membership.member?
        return redirect_to :back, alert: t('alert.memberships.already_member')
      # Already invited
      else
        return redirect_to :back, alert: t('alert.memberships.already_invited')
      end
    else
      room.invited_users << user_to_invite
      room.save
    end
    redirect_to room_path(room), notice: t('notice.rooms.invited')
  end

  private
  def room_params
    params.require(:room).permit(:screen_name, :display_name, :description, :private)
  end

  def set_room
    @room = Room.find(params[:id])
    authorize @room
  end

  def set_room_by_screen_name
    @room = Room.find_by(screen_name: params[:screen_name])
    authorize @room
  end

end
