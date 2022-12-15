class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.references :member, null: false, foreign_key: true
      t.references :beer, null: false, foreign_key: true
      t.references :bar, foreign_key: true
      t.references :shop, foreign_key: { to_table: :bars }
      t.text :content
      t.float :evaluation
      t.integer :serving_style, null: false, default: 0
      t.boolean :is_closed, null: false, default: false

      t.timestamps
    end
  end
end
