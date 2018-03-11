class AddAvatarToIngredients < ActiveRecord::Migration[5.1]
  def change
    add_column :ingredients, :avatar, :string
  end
end
