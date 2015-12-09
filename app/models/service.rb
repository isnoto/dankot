class Service < ActiveRecord::Base
  validates :name, presence: true

  default_scope { order("created_at ASC") }
end
