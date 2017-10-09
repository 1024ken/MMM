Rails.application.routes.draw do

  root 'top#index'

  resources :mmms, only:[:index]

  resources :blogs, only:[:index, :new, :create, :edit, :update, :destroy] do
    resources :comments
    collection do
      post :confirm
      get :top5
    end
  end

  resources :users, only: [:index] do
  end

  post   '/like/:blog_id' => 'likes#like',   as: 'like'
  delete '/like/:blog_id' => 'likes#unlike', as: 'unlike'

  resource :relationships, only: [:create, :destroy]
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  resources :conversations do
    resources :messages
  end

  devise_for :users, controllers: {
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
