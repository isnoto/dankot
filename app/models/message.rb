class Message
  include ActiveModel::Model
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :name, :email, :phone, :text

  validates :name,
            presence: true

  validates :phone,
            presence: true
end