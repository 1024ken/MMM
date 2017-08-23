Rails.application.routes.draw do
  root 'mmms#index'
  resources :mmms
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
