class FriendshipChannel < ApplicationCable::Channel
  def subscribed
    stream_from "friendships-#{current_user.id}"
  end

  def unsubscribed
    stop_all_streams
  end

  class << self
    def sent(**data)
      ActionCable.server.broadcast(
        "friendships-#{data[:user_id]}",
        message: data[:message]
      )
    end
  end

  def sent; end
end
