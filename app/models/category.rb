class Category < ActiveRecord::Base
  has_many :portfolio_photos, dependent: :destroy

  validates :display_name, presence: true, uniqueness: true

  def self.collection
    all.map { |i| [i.display_name, i.id] }
  end
end
