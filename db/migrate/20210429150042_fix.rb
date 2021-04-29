class Fix < ActiveRecord::Migration[5.2]
  def change
    change_column :works, :medium, :integer
    remove_column :works, :image_id, :string
  end
end
