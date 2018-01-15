Rails.application.routes.draw do
  devise_for :users
  root 'posts#index'
  resources :posts do
    resources :comments
  end
  resources :pictures, only: [:create, :destroy]
  get 'myposts' => 'posts#myposts'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
