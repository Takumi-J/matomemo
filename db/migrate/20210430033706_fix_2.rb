class Fix2 < ActiveRecord::Migration[5.2]
  def change
    remove_column :comments, :work_id, :integer
    add_column :comments, :forum_id, :integer
    add_column :forums, :member_id, :integer
  end
end
