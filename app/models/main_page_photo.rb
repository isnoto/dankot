class MainPagePhoto < ActiveRecord::Base
  mount_uploader :image, MainPageImageUploader

  validates :image, presence: true
  validates :position, numericality: { greater_than_or_equal_to: 0 }

  default_scope { order("position") }

  def get_position
    positions = MainPagePhoto.all.map(&:position)
    new_position = positions.present? ? positions.max + 1 : 1

    if position == 0
      new_position
    else
      position
    end
  end
end
