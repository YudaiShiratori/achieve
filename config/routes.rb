Rails.application.routes.draw do

  get 'blogs/index'

  resources :blogs do
      post :confirm, on: :collection
      patch :edit_confirm, on: :member
      resources :comments
  end
  
  resources :contacts, only: [:new, :create, :show, :confirm ] do
  end
  
  resources  :tops, only: [:index] do
  end
  
  resources  :users do
  end

  resources  :sessions, only:[:new, :create, :destroy]
  
  resources  :favorites, only:[:create, :destroy]
  
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  
  root to: 'tops#index'
  
end
