class Service < ActiveRecord::Base
  validates :name, presence: true
end
