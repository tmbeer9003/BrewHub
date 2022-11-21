class CreateBeers < ActiveRecord::Migration[6.1]
  def change
    create_table :beers do |t|
      t.references :beer_style, null: false, foreign_key: true
      t.references :brewery, null: false, foreign_key: true
      t.string :name, null: false
      t.float :abv
      t.float :ibu
      t.text :description

      t.timestamps
    end
    
    add_index :beers, :name, unique: true
  end
end
