class HomeController < ApplicationController
  def index
    session[:conversations] ||= []

    @friends = current_user.conversations.accepted
    @users = User.all.where.not(id: current_user)
    @conversations = Conversation.includes(:recipient, :messages)
                               # .find(session[:conversations])
    #TODO: user remove but session also have it info
  end
end
