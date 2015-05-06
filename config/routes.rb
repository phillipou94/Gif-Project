Rails.application.routes.draw do
  root 'static_pages#home'
  post 'signup' => 'users#signup'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  post 'create_channel' => 'channels#create'
  post 'get_gif' => 'static_pages#get_gif_for_channel'
  post 'save_gif' =>  'static_pages#save_gif'
  #resources :sessions
end
