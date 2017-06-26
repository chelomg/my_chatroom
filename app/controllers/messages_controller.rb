class MessagesController < ApplicationController
  def create
    @conversation = Conversation.includes(:recipient).find(params[:conversation_id])
    @message = @conversation.messages.create(message_params)

    respond_to do |format|
      format.js
    end
  end

  def new
    @message = Message.new
  end

  def sent
    if User.all.count - Conversation.my_relation(current_user.id).count > 1
      random_user = random_pick
      conversation = Conversation.new(sender_id: current_user.id, recipient_id: random_user.id, status: 0, action_id: current_user.id)
      render :new, alert: 'conversation error' unless conversation.save
      message = conversation.messages.new(params.require(:message).permit(:body))
      message.user_id = current_user.id
      render :new, alert: 'message save error' unless message.save
      redirect_to root_path, notice: 'send OK'
    else
      render :new, alert: 'no user can pending'
    end
  end

  private

  def message_params
    params.require(:message).permit(:user_id, :body)
  end

  def random_pick
    result = []
    Conversation.my_relation(current_user).each do |conversation|
      if conversation.recipient_id == current_user.id
        result << conversation.sender_id
      else
        result << conversation.recipient_id
      end
    end

    User.where.not(id: result).sample
  end
end
