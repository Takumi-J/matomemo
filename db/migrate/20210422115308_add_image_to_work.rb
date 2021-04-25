class AddImageToWork < ActiveRecord::Migration[5.2]
  def change
    add_column :works, :image, :string
  end
end
