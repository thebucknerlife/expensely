Rails.application.routes.draw do
  root to: 'pages#landing'

  get '/welcome' => 'pages#homepage'
  get '/install' => 'pages#add_to_slack'

  get '/auth/slack' => 'auth#slack', as: :auth
  get '/auth/success' => 'auth#success', as: :success
  get '/auth/sad' => 'auth#failed', as: :failed

  resources :requests, only: [:show, :update]
  resources :request_items, only: [:create, :update]
  resources :receipts, only: [:create, :update]
end
