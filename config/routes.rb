Rails.application.routes.draw do
  get 'sessions/new'

  resources :blogs do
    collection do
      post :confirm
    end
  end
  
  resources :contacts, only: [:new, :create] do
  end
  
  resources  :tops, only: [:index] do
  end
  
  resources  :users do
  end

  resources  :sessions, only:[:new, :create, :destroy]

  
  root to: 'tops#index'
  
end
