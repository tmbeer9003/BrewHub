class CreateBars < ActiveRecord::Migration[6.1]
  def change
    create_table :bars do |t|
      t.string :name, null:false
      t.integer :location, null:false, default: 0

      t.timestamps
    end
  end
end
