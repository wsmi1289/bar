json.extract! recipe_ingredient, :id, :quantity, :created_at, :updated_at
json.url recipe_ingredient_url(recipe_ingredient, format: :json)
