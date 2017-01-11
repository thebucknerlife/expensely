Rails.application.routes.draw do
  get '/requests/:id' => 'requests#edit', as: :edit_request
  patch '/requests/:id' => 'requests#edit', as: :update_request
end
