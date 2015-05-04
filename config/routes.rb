Rails.application.routes.draw do
  root 'static_pages#home'
  post 'signup' => 'users#signup'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  post 'create_channel' => 'channels#create'
  #resources :sessions
end
