class Ingredient < ApplicationRecord
  has_one :type
  belongs_to :bar
  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredients
  # accepts_nested_attributes_for :type

  def ingredient_name
    "#{name}"
  end

  def type_name(type_id)
    Type.find(type_id).name
  end
end
