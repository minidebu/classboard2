Rails.application.routes.draw do
  devise_for :users
  root to: 'plans#index'
  resources :students ,only:[:index,:new,:create,:update,:show]  do
    resources :student_schedules ,only:[:index ,:create]
  end
  resources :schedules,only:[:index,:create]
  resources :plans ,only:[:index,:new,:create]
  resources :lessons ,only:[:create,:destroy]


  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
