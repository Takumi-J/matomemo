class CreateReviewMngs < ActiveRecord::Migration[5.2]
  def change
    create_table :review_mngs do |t|
      
      t.integer :member_id  ,null: false
      t.integer :review_id  ,null: false
      t.boolean :favorite   ,default: false

      t.timestamps
    end
  end
end
