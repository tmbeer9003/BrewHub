class CreateGroupsMembers < ActiveRecord::Migration[6.1]
  def change
    create_table :groups_members do |t|
      t.references :group, null: false, foreign_key: true
      t.references :member, null: false, foreign_key: true

      t.timestamps

      t.index [:group_id, :member_id], unique: true
    end
  end
end
