Rails.application.routes.draw do

  devise_for :users
  resources :types
  resources :users do
    resources :bars do
      resources :recipe_ingredients do
        get 'autocomplete_ingredient_name', on: :collection
      end
      resources :recipes do
        get 'possible', on: :member
        get 'autocomplete_recipe_name', on: :collection
      end
      resources :ingredients do
        get 'filter', on: :collection
        post 'toggle', on: :member
      end
    end
  end
  
  root 'bars#index'
  # post 'users/:user_id/bars/:bar_id/ingredients/toggle', to: 'ingredients#toggle'
end
