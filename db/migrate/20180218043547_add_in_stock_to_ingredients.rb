class AddInStockToIngredients < ActiveRecord::Migration[5.1]
  def change
    add_column :ingredients, :in_stock, :boolean, default: true
    add_column :ingredients, :type, :string
  end
end
