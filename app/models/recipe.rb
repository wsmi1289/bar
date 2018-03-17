class Recipe < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients
  accepts_nested_attributes_for :recipe_ingredients, allow_destroy: true
  # def recipe_name
  #   "#{name}"
  # end
end
