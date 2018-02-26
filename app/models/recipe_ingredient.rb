class RecipeIngredient < ApplicationRecord
  belongs_to :recipe
  belongs_to :ingredient

  # <div class="field">
  #   <%= f.label :ingredient %>
  #   <%= f.autocomplete_field :ingredient, autocomplete_ingredient_name_user_bar_recipe_ingredients_path, id_element: 'recipe_recipe_ingredients_attributes_0_ingredient_id' %>
  # </div>
  # def ingredient_name
  #   ingredient = Ingredient.where(bar_id: @bar, in_stock: true).pluck(:name)
  #   return "#{ingredient}"
  # end
  #     <div class="field">
  #   <%= f.label :ingredient %>
  #   <%= f.collection_select :ingredient_id, Ingredient.where(bar_id: params[:bar_id], in_stock: true), :id, :ingredient_name, prompt: true %>
  # </div>

end
