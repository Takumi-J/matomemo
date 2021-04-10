class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    drop_table :follows
    
    create_table :relationships do |t|

      t.references :member, foreign_key: true
      t.references :follow, foreign_key: { to_table: :members }

      t.timestamps

      t.index [:member_id, :follow_id], unique: true


      t.timestamps
    end
  end
end
