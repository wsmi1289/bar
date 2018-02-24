class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, request_keys: [:subdomain]

  has_many :bars

  def set_current_bar(bar_id)
    self.bar_id = @bar.id
    self.save
  end

  def drinks_user_can_make
    current_ingredients = Set.new(self.current_bar.bar.ingredients.map{|bar_item| bar_item.ingredient})

    makeable_drinks = []
    Drink.all.each do |drink|
      drink_ingredients = Set.new(drink.drink_items.map{|drink_item| drink_item.ingredient})

      makeable_drinks << drink if (drink_ingredients - current_ingredients).empty?
    end

    makeable_drinks
  end
end
