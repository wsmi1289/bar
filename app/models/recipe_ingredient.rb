class RecipeIngredient < ApplicationRecord
  belongs_to :recipe
  belongs_to :ingredient

  def ingredient_name
    ingredient = Ingredient.find(params[:ingredient_id])
    ing_name = ingredient.name
    return "#{ing_name}"
  end
end
