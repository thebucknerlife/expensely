Rails.application.routes.draw do
  get '/requests/:id' => 'requests#edit'
  patch '/requests/:id' => 'requests#edit'
end
