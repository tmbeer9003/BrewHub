class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.references :member, null: false, foreign_key: true
      t.references :follow, null: false, foreign_key: { to_table: :members }

      t.timestamps

      t.index [:member_id, :follow_id], unique: true
    end
  end
end
