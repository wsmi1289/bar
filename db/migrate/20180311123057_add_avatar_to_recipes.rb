class AddAvatarToRecipes < ActiveRecord::Migration[5.1]
  def change
    add_column :recipes, :avatar, :string
  end
end
