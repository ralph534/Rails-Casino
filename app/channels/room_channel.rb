class RoomChannel < ApplicationCable::Channel
  def subscribed
    room = current_user.current_room
    stream_from "room_channel_#{room}"
    stream_from "room_channel_#{current_user.id}"
  end

  def unsubscribed
    # current_user.update!(current_room: nil)
    current_user.update!(turn: false)
  end
end
