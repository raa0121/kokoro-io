class RoomsController < ApplicationController
  before_action :authenticate_user, only: %i[ join leave create new update edit ]

  def create
    @room = current_user.rooms.create permitted_params[:room]
    membership = @room.memberships.first
    membership.administer! if membership
    create! do |success, failure|
      success.html { redirect_to room_path(@room), notice: t('rooms.created') }
    end
  end

  def show
    @room = Room.find_by(params[:id])
  end

  def index
    @rooms = Room.public_rooms
  end

  def destroy
    @room = current_user.rooms.find_by permitted_params[:room]
  end

  def join
    room = Room.where(screen_name: params[:screen_name]).limit(1).first
    return redirect_to :back, alert: t('alert.rooms.not_exist') unless room
    return redirect_to :back, alert: t('alert.rooms.not_joinbale') unless room.joinable? current_user

    if room.users.include? current_user
      room.memberships.where(memberable: current_user).limit(1).first.try(:member!)
    else
      room.users << current_user
      room.save
    end
    redirect_to room_path(room), notice: t('notice.rooms.joined')
  end

  def leave
    room = Room.where(screen_name: params[:screen_name]).limit(1).first
    return redirect_to :back, alert: t('alert.rooms.not_exist') unless room
    return redirect_to :back, alert: t('alert.rooms.not_leaveable') unless room.leaveable? current_user

    room.users.delete current_user
    room.save
    return redirect_to room_path(room), notice: t('notice.rooms.leaved') if room.public?
    return redirect_to rooms_path, notice: t('notice.rooms.leaved') if room.private?
  end

  private
  def permitted_params
    params.permit(room: [:screen_name, :room_name, :description, :private])
  end

end
