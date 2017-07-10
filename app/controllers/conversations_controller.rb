class ConversationsController < ApplicationController
  before_action :find_conversation, only: [:close, :decline, :accept]

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
    session[:conversations].delete(@conversation.id)

    respond_to do |format|
      format.js
    end
  end

  def decline
    @conversation.update_attributes(status: 2, action_id: current_user.id)
    session[:conversations].delete(@conversation.id)

    respond_to do |format|
      format.js
    end
  end

  def accept
    @accept_user = User.find(@conversation.action_id)
    @conversation.update_attributes(status: 1, action_id: current_user.id)

    FriendshipChannel.response_accepted(@accept_user, current_user)
    add_to_conversations unless conversated?

    respond_to do |format|
      format.js
    end
  end

  private
  def find_conversation
    @conversation = Conversation.find(params[:id])
  end

  def add_to_conversations
    session[:conversations] ||= []
    session[:conversations] << @conversation.id
  end

  def conversated?
    session[:conversations].include?(@conversation.id)
  end
end
