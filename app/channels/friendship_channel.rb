class FriendshipChannel < ApplicationCable::Channel
  def subscribed
    stream_from "friendships-#{current_user.id}"
  end

  def unsubscribed
    stop_all_streams
  end

  def sent; end
end
