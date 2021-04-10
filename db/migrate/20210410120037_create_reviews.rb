class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      
      t.integer :member_id  ,null: false
      t.integer :work_id    ,null: false
      t.integer :score      ,null: false
      t.string  :title      ,null: false
      t.text    :sentence   ,null: false

      t.timestamps
    end
  end
end
