Rails.application.routes.draw do
  root to: "sessions#new"
  resources :favorites, only: [:create, :destroy]
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]
  resources :blogs do
    collection do
      post :confirm
    end
  end
  resources :contacts do
  end
  
  if Rails.env.development?
  mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end