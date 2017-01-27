Rails.application.routes.draw do
  resources :requests, only: [:show, :update]
  resources :request_items, only: [:create, :update]
  resources :receipts, only: [:create, :update]
end
