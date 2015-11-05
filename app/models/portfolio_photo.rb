class PortfolioPhoto < ActiveRecord::Base
  belongs_to :category

  mount_uploader :image, PortfolioImageUploader

  validates :image, :category_id, presence: true
end
