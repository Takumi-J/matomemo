class CreateGenreMngs < ActiveRecord::Migration[5.2]
  def change
    create_table :genre_mngs do |t|
      
      t.integer :genre_id   ,null: false
      t.integer :work_id    ,null: false
      
      t.timestamps
    end
  end
end
