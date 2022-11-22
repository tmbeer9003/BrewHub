class CreateGroupPosts < ActiveRecord::Migration[6.1]
  def change
    create_table :group_posts do |t|
      t.references :group, null: false, foreign_key: true
      t.references :member, null: false, foreign_key: true
      t.string :title, null: false
      t.text :content

      t.timestamps
    end
  end
end
