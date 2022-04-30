Rails.application.routes.draw do
  devise_for :users
  root to: 'students#index'
  resources :students ,only:[:index,:new,:create,:edit]
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
