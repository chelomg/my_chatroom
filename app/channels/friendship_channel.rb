class FriendshipChannel < ApplicationCable::Channel
  def subscribed
    stream_from "friendships-#{current_user.id}"
  end

  def unsubscribed
    stop_all_streams
  end

  def sent; end

  class << self
    def response_accepted(accepted_user, current_user)
      ActionCable.server.broadcast(
        "friendships-#{accepted_user.id}",
        list: ApplicationController.render(
          partial: 'conversations/list_item',
          locals: { accept_user: current_user }
        )
      )
    end
  end
end
