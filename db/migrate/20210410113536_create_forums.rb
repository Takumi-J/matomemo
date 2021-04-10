class CreateForums < ActiveRecord::Migration[5.2]
  def change
    create_table :forums do |t|
      
      t.integer :work_id    ,null: false
      
      t.string  :title        ,null: false
      t.text    :summary     ,null: false
      

      t.timestamps
    end
  end
end
