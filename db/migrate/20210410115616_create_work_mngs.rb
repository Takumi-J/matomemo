class CreateWorkMngs < ActiveRecord::Migration[5.2]
  def change
    create_table :work_mngs do |t|
      
      t.integer :member_id  ,null: false
      t.integer :work_id    ,null: false
      t.integer :category   ,null: false

      t.timestamps
    end
  end
end
