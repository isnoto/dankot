class FeedbackMailer < ApplicationMailer
  default from: Rails.application.secrets.smtp_email_address

  def new_message(message)
    @message = message

    mail(to: Rails.application.secrets.smtp_email_reciever, subject: 'Dankot.net Новое сообщение')
  end
end
