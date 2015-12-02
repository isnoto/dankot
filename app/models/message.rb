class Message
  include ActiveModel::Model
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :name, :email, :phone, :text

  EMAIL_REGEXP = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates :name,
            presence: true

  validates :email,
            presence: true,
            format: { with: EMAIL_REGEXP }

  validates :phone,
            presence: true

  validates :text,
            presence: true
end