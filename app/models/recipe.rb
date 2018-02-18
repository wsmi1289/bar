class Recipe < ApplicationRecord
  has_many :recipe_ingredients
  accepts_nested_attributes_for :recipe_ingredients, allow_destroy: true
  def recipe_name
    "#{name}"
  end
end
