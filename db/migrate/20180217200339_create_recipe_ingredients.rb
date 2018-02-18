class CreateRecipeIngredients < ActiveRecord::Migration[5.1]
  def change
    create_table :recipe_ingredients do |t|
      t.string :quantity
      t.integer :recipe_id
      t.integer :ingredient_id

      t.timestamps
    end
    add_index :recipe_ingredients, :recipe_id
    add_index :recipe_ingredients, :ingredient_id
  end
end
