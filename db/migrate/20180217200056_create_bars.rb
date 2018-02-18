class CreateBars < ActiveRecord::Migration[5.1]
  def change
    create_table :bars do |t|
      t.string :name
      t.integer :user_id
      t.timestamps
    end
    add_index :bars, :user_id
  end
end
