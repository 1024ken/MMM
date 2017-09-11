Rails.application.routes.draw do

  resources :blogs, only:[:index, :new, :create, :edit, :update, :destroy] do
    collection do
      post :confirm
    end
  end
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  devise_for :users

  resources :mmms

  root 'top#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
