class CreateBars < ActiveRecord::Migration[6.1]
  def change
    create_table :bars do |t|
      t.integer :category, null: false
      t.string :place_name, null: false
      t.float :latitude, null: false
      t.float :longitude, null: false

      t.timestamps
    end
  end
end
