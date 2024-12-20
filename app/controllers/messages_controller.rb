class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :destroy]

  def index
    current_user_id = current_user.id

    received_messages = Message.where({ recipient_id: current_user_id })
    sent_messages = Message.where({ sender_id: current_user_id })

    all_messages = received_messages.or(sent_messages)

    @latest_messages = Message.latest_messages_for_user(current_user.id)
  end

  def new
    @message = Message.new(sender_id: current_user.id, recipient_id: params[:user_id])
  end

  def create
    @message = Message.new(message_params)
    @message.sender_id = session.fetch("sender_id")
    @message.recipient_id = session.fetch("recipient_id")

    if @message.save
      respond_to do |format|
        format.html do
          if request.headers["Turbo-Frame"] #Nice use of turbo
            render({ :partial => "messages/message", :locals => { :message => @message } })
          else
            redirect_to "/messages/conversation/#{@message.recipient_id}?current_user_id=#{@message.sender_id}", :notice => "Message was successfully created."
          end
        end
        format.json { render :show, :status => :created, :location => @message }
      end
    else
      respond_to do |format|
        format.html { render :new, :status => :unprocessable_entity }
        format.json { render :json => @message.errors, :status => :unprocessable_entity }
      end
    end
  end

  def conversation
    current_user_id = current_user.id
    other_user_id = params.fetch("user_id")

    session.store("sender_id", current_user_id)
    session.store("recipient_id", other_user_id)

    @message = Message.new

    @messages = Message.where({ sender_id: current_user_id, recipient_id: other_user_id })
                       .or(Message.where({ sender_id: other_user_id, recipient_id: current_user_id }))
    render({ template: "messages/conversation" })
  end

  def destroy
    @message.destroy!
  
    respond_to do |format|
      format.html do
        redirect_to "/messages/conversation/#{session[:recipient_id]}?current_user_id=#{session[:sender_id]}",
                    notice: "Message was successfully deleted."
      end
      format.json { head :no_content }
    end
  end
  

  private

  def set_message
    @message = Message.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:body, :sender_id, :recipient_id)
  end
end
