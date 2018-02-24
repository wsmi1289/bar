class AddTypeReferenceToIngredient < ActiveRecord::Migration[5.1]
  def change
    remove_column :ingredients, :type, :string
    add_column :ingredients, :type_id, :integer
    add_index :ingredients, :type_id
  end
end
