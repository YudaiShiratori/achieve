Rails.application.routes.draw do
  resources :blogs do
    collection do
      post :confirm
    end
  end
  
  resources :contacts, only: [:new, :create] do
  end
  
  resources  :tops, only: [:index] do
  end
  
  root to: 'tops#index'
  
end
