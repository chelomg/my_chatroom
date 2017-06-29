class ConversationsController < ApplicationController
  def show
    @conversation = Conversation.get(current_user.id, params[:id])

    add_to_conversations unless conversated?

    respond_to do |format|
      format.js
    end
  end

  def bottle
    @conversation = Conversation.between(current_user.id, params[:id]).first
    @user = current_user
    #add_to_conversations unless conversated?
    respond_to do |format|
      format.js
    end
  end

  def close
    @conversation = Conversation.find(params[:id])

    session[:conversations].delete(@conversation.id)

    respond_to do |format|
      format.js
    end
  end

  def decline
    @conversation = Conversation.find(params[:id])
    @conversation.update_attributes(status: 2, action_id: current_user.id)
    session[:conversations].delete(@conversation.id)

    respond_to do |format|
      format.js
    end
  end

  def accept
    @conversation = Conversation.find(params[:id])
    @accept_user = User.find(@conversation.action_id)
    @conversation.update_attributes(status: 1, action_id: current_user.id)

    FriendshipChannel.response_accepted(@accept_user, current_user)
    add_to_conversations unless conversated?

    respond_to do |format|
      format.js
    end
  end

  private

  def add_to_conversations
    session[:conversations] ||= []
    session[:conversations] << @conversation.id
  end

  def conversated?
    session[:conversations].include?(@conversation.id)
  end
end
