Rails.application.routes.draw do

  resources :types
  devise_for :users
  resources :users do
    resources :bars do
      resources :recipe_ingredients
      resources :recipes do
        get 'possible', on: :member
      end
      resources :ingredients do
        get 'filter', on: :collection
      end
    end
  end
  root 'users#index'
  post 'users/:user_id/bars/:bar_id/ingredients/toggle', to: 'ingredients#toggle'
  # get '/welcome' => "bars#index", as: :user_root
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
