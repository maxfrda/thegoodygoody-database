Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'pages#home'

  resources :artists, only: [:index, :show]
  resources :labels, only: [:index, :show]
  resources :releases, only: [:index]


end
