module RecipesHelper

  def possible_recipes
    ingredients = Ingredient.where(bar_id: @bar, in_stock: true)
    possible_recipes = []
    Recipe.all.each do |recipe|
      drink_ingredients = recipe.recipe_ingredients.map{|drink| drink.ingredient}
      possible_recipes << recipe if (drink_ingredients - ingredients).empty?
    end
    possible_recipes
  end
end
