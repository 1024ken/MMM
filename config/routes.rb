Rails.application.routes.draw do

  root 'top#index'

  resources :mmms

  resources :blogs, only:[:index, :new, :create, :edit, :update, :destroy] do
    collection do
      post :confirm
    end
  end

  resources :users, only: [:index] do
  end

  post   '/like/:blog_id' => 'likes#like',   as: 'like'
  delete '/like/:blog_id' => 'likes#unlike', as: 'unlike'

  root 'tweets#index'

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

  resources :blogs do
    resources :comments
    post :confirm, on: :collection
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
