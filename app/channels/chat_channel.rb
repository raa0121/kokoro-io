class ChatChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    current_user.chattable_rooms.each do |r|
      stream_from r.id
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  #
  def subscribe(screen_names)
    # Ensure it is array
    screen_names = [screen_names].flatten

    # Subscribe if user is chattable
    screen_names.each do |screen_name|
      room = current_user.chattable_rooms.find_by(scree_name: screen_name)
      stream_from room.id if room
    end
  end

end
