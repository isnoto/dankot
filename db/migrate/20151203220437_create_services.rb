class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.text :name
      t.text :description
      t.string :value

      t.timestamps null: false
    end
  end
end
