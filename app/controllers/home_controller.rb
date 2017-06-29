class HomeController < ApplicationController
  def index
    session[:conversations] = []
    @friends = User.where(id: Conversation.find_friends(current_user))
    #@friends = current_user.conversations.accepted
    @request_users = User.where(id: Conversation.find_request_users(current_user))
    @users = User.all.where.not(id: current_user)
    @conversations = Conversation.includes(:recipient, :messages).accepted
                             .find(session[:conversations])
    #TODO: user remove but session also have it info
  end
end
