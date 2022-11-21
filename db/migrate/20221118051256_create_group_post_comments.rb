class CreateGroupPostComments < ActiveRecord::Migration[6.1]
  def change
    create_table :group_post_comments do |t|
      t.references :group_post, null: false, foreign_key: true
      t.references :member, null: false, foreign_key: true
      t.text :content, null: false

      t.timestamps
    end
  end
end
