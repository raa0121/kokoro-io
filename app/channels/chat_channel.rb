class ChatChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  #
  def subscribe(data)
    access_token = data["access_token"]
    screen_names = [data["rooms"]].flatten
    user = AccessToken.find_by(token: access_token).try(:user)
    # Ensure it is array
    return unless user

    # Subscribe if user is chattable
    screen_names.each do |screen_name|
      if (room = user.chattable_rooms.find_by(screen_name: screen_name))
        stream_from room.id
      end
    end
  end

end
