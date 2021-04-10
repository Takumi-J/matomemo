class CreateForumMngs < ActiveRecord::Migration[5.2]
  def change
    create_table :forum_mngs do |t|
      
      t.integer :forum_id   ,null: false
      t.integer :member_id  ,null: false
      t.boolean :favorite   ,default: false

      t.timestamps
    end
  end
end
