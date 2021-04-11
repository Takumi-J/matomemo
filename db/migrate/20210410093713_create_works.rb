class CreateWorks < ActiveRecord::Migration[5.2]
  def change
    create_table :works do |t|
      
      t.string  :image_id
      t.string  :medium       ,null: false
      t.string  :title        ,null: false
      t.text    :synopsis     ,null: false
      t.string  :author       ,null: false
      t.date    :release_date ,null: false
      
      t.timestamps
    end
  end
end
