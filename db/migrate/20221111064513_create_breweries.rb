class CreateBreweries < ActiveRecord::Migration[6.1]
  def change
    create_table :breweries do |t|
      t.string :name, null: false
      t.text :description
      t.integer :location, null: false, default: 0

      t.timestamps
    end
  end
end
