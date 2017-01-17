Rails.application.routes.draw do
  resources :test_cases, only: :show
  root to: 'top#show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
