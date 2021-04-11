class CreateActorMngs < ActiveRecord::Migration[5.2]
  def change

    create_table :actor_mngs do |t|

      t.integer :actor_id   ,null: false
      t.integer :work_id    ,null: false

      t.timestamps
    end
  end
end
