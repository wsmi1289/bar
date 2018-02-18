class Ingredient < ApplicationRecord
  belongs_to :bar
  has_many :recipe_ingredients

  def ingredient_name
    "#{name}"
  end
end
