class MessagesController < ApplicationController
  before_action :set_message, only: [ :show, :edit, :update, :destroy ]

  # GET /messages or /messages.json
  def index
    current_user_id = current_user.id

    received_messages = Message.where({ recipient_id: current_user_id })
    sent_messages = Message.where({ sender_id: current_user_id })

    all_messages = received_messages.or(sent_messages)

    @latest_messages = all_messages.group_by { |message| [ message.sender_id, message.recipient_id ].sort }
                                   .map { |_, messages| messages.max_by { |message| message.created_at } }
  end

  # GET /messages/1 or /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages or /messages.json
  def create
    @message = Message.new(message_params)

    respond_to do |format|
      if @message.save
        format.html { redirect_to "/messages/conversation/#{@message.recipient_id}?current_user_id=#{@message.sender_id}", notice: "Message was successfully created." }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1 or /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to message_url(@message), notice: "Message was successfully updated." }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1 or /messages/1.json
  def destroy
    @message.destroy!

    respond_to do |format|
      format.html { redirect_to messages_url, notice: "Message was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def conversation
    current_user_id = current_user.id
    other_user_id = params.fetch("user_id")

    @message = Message.new(sender_id: params[:current_user_id], recipient_id: params[:user_id])

    @messages = Message.where({ sender_id: current_user_id, recipient_id: other_user_id })
                       .or(Message.where({ sender_id: other_user_id, recipient_id: current_user_id }))
    render({ template: "messages/conversation" })
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_message
    @message = Message.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def message_params
    params.require(:message).permit(:body, :sender_id, :recipient_id)
  end
end
