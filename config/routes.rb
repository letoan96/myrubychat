Rails.application.routes.draw do
  root 'home#index'  
  resources :blocks
  resources :friends
  resources :messages
  resources :sessions, only: [:new, :create]
  resources :users
  get 'log_out' => 'sessions#destroy', to: 'home#index'
  get 'sent_index' => 'messages#sent_index'
  delete 'unfriend' => 'friends#destroy'
  delete 'block' => 'blocks#destroy'

end
