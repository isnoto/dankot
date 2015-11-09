class MainPagePhoto < ActiveRecord::Base
  mount_uploader :image, MainPageImageUploader

  validates :image, presence: true
  validates :position, numericality: { greater_than_or_equal_to: 0 }

  default_scope { order("position") }

  def get_position
    positions = MainPagePhoto.all.map(&:position)

    if positions.present?
      new_position = positions.max + 1
    else
      new_position = 1
    end

    position == 0 ? new_position : position
  end
end
