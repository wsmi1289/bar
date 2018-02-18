class CreateIngredients < ActiveRecord::Migration[5.1]
  def change
    create_table :ingredients do |t|
      t.string :name
      t.text :description
      t.integer :bar_id
      t.boolean :is_bar_ingredient, default: true
      t.timestamps
    end
    add_index :ingredients, :bar_id
  end
end
