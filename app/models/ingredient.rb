class Ingredient < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  # has_one :type
  belongs_to :bar
  has_many :recipe_ingredients, dependent: :destroy
  has_many :recipes, through: :recipe_ingredients

  def ingredient_name
    "#{name}"
  end

  def self.search(term)
    if term
      where('LOWER(name) LIKE :term', term: "%#{term.downcase}%")
    else
      where(bar_id: @bar)
    end
  end

  def type_name(type_id)
    Type.find(type_id).name
  end
end
