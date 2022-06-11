Rails.application.routes.draw do
  resources :categories do
    resources :tasks
  end
  devise_for :users 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # devise_scope :user do 
  #   root to: 'devise/sessions#create'
  # end
  root to: 'categories#index'
end
