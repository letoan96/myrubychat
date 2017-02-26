Rails.application.routes.draw do
  root 'home#index'  
  resources :blocks
  resources :friends
  resources :messages
  resources :sessions, only: [:new, :create]
  resources :users
  get 'log_out' => 'sessions#destroy'
  get 'sent_index' => 'messages#sent_index'
  get 'unfriend' => 'friends#destroy'
  get 'unblock' => 'blocks#destroy'

end
