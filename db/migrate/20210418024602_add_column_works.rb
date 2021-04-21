class AddColumnWorks < ActiveRecord::Migration[5.2]
  def up
    add_column :works, :source, :string
    change_column :works, :source, :string, :null => false
  end

  def down
    remove_column :works, :source
  end
end
