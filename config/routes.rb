Rails.application.routes.draw do
  root to: 'home#index'
  get 'home', to: 'home#index'
  devise_for :users
  resources :boards, only: %i[index show new create edit update destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
