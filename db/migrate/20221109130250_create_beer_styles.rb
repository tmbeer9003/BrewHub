class CreateBeerStyles < ActiveRecord::Migration[6.1]
  def change
    create_table :beer_styles do |t|
      t.string :name, null: false
      t.integer :category, null: false, default: 0

      t.timestamps
    end
  end
end
