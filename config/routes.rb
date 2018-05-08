Rails.application.routes.draw do
  get 'blogs/index'

  resources :blogs do
    collection do
      post :confirm
    end
  end
  
  resources :contacts, only: [:new, :create, :show, :confirm ] do
  end
  
  resources  :tops, only: [:index] do
  end
  
  resources  :users do
  end

  resources  :sessions, only:[:new, :create, :destroy]
  
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  
  root to: 'tops#index'
  
end
