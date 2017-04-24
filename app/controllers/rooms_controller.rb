class RoomsController < ApplicationController

  def create
    @room = current_user.rooms.create(permitted_params[:room])
    membership = @room.memberships.first
    membership.administrator! if membership

    # FIXME: error handling
    if @room.persisted?
      redirect_to(room_path(@room), notice: t('rooms.created'))
    end
  end

  def new
    @room = Room.new
  end

  def show
    @room = Room.friendly.find(params[:id])
  end

  def index
    @rooms = Room.public_rooms
  end

  def destroy
    @room = current_user.rooms.find_by(id: params[:id])
    # TODO:Authority check
  end

  def join
    room = Room.find_by(screen_name: params[:screen_name])
    return redirect_to :back, alert: t('alert.rooms.not_exist') unless room
    return redirect_to :back, alert: t('alert.rooms.not_joinbale') unless room.joinable? current_user

    if room.users.include? current_user
      room.memberships.find_by(memberable: current_user)&.member!
    else
      room.users << current_user
      room.save
    end
    redirect_to room_path(room), notice: t('notice.rooms.joined')
  end

  def leave
    room = Room.find_by(screen_name: params[:screen_name])
    return redirect_to :back, alert: t('alert.rooms.not_exist') unless room
    return redirect_to :back, alert: t('alert.rooms.not_leaveable') unless room.leaveable? current_user

    room.users.delete current_user
    room.save
    return redirect_to room_path(room), notice: t('notice.rooms.leaved') if room.public?
    return redirect_to rooms_path, notice: t('notice.rooms.leaved') if room.private?
  end

  def invite
    room = Room.find_by(screen_name: params[:screen_name])
    return redirect_to :back, alert: t('alert.rooms.not_exist') unless room
    return redirect_to :back, alert: t('alert.rooms.not_invitable') unless room.invitable? current_user

    user_to_invite = User.find_by(id: params[:user_id])
    return redirect_to :back, alert: t('alert.users.not_exist') unless user_to_invite

    if room.users.include? user_to_invite
      membership = room.memberships.find(memberable: user_to_invite)
      # Already have membership
      if membership.administer? || membership.maintainer? || membership.member?
        return redirect_to :back, alert: t('alert.memberships.already_member')
      # Already invited
      else
        return redirect_to :back, alert: t('alert.memberships.already_invited')
      end
    else
      room.users << user_to_invite
      room.save
    end
    redirect_to room_path(room), notice: t('notice.rooms.invited')
  end

  private
  def permitted_params
    params.permit(room: [:screen_name, :display_name, :description, :private])
  end
end
