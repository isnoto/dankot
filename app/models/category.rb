class Category < ActiveRecord::Base
  has_many :portfolio_photos, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :display_name, presence: true, uniqueness: true

  before_save :to_lower

  def self.collection
    all.map { |i| [i.display_name, i.id] }
  end

  private

  def to_lower
    self.name = self.name.downcase
  end
end
