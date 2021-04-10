class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      
      
      t.integer :member_id  ,null: false
      t.integer :work_id    ,null: false
      t.string  :opinion    ,null: false

      t.timestamps
    end
  end
end
