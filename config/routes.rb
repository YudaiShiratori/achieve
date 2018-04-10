Rails.application.routes.draw do
  resources :blogs do
    collection do
      post :confirm
    end
  end
  
  resources :contacts, only: [:new, :create] do
  end
  
  root to: 'blogs#index'
end
