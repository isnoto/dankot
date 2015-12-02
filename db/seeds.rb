User.create(
  email: Rails.application.secrets.user_email,
  password: Rails.application.secrets.user_password,
  password_confirmation: Rails.application.secrets.user_password
)