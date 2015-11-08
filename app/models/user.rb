class User < ActiveRecord::Base
  authenticates_with_sorcery!

  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }, confirmation: true
  validates :password_confirmation, presence: true
end
