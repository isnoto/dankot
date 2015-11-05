class CreateMainPagePhotos < ActiveRecord::Migration
  def change
    create_table :main_page_photos do |t|
      t.string :image
      t.integer :position, default: 0

      t.timestamps null: false
    end
  end
end
