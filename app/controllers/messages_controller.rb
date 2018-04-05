class MessagesController < ApplicationController
  before_action :get_messages

  def index
  end

  def create 
    message = current_user.messages.build(message_params)
    puts message
    if message.save
      ActionCable.server.broadcast 'room_channel',
                                    content: message.content,
                                    username: message.user.username
    # else
    #   render 'index'
    end
  end

  private 
    def get_messages 
      @messages = Message.for_display 
      @message = current_user.messages.build 
    end

    def message_params
      params.require(:message).permit(:content)
    end
end
