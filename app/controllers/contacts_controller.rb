class ContactsController < ApplicationController
  def new
    @message = Message.new
  end

  def create
    @message = Message.new(contact_params)

    if @message.valid?
      FeedbackMailer.new_message(@message).deliver_now
      redirect_to contacts_path, notice: ''
    end
  end

  private

  def contact_params
    params.require(:message).permit(:name, :email, :phone, :text)
  end
end
