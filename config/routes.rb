Rails.application.routes.draw do
  resources :blocks
  resources :friends
  resources :messages
  resources :sessions, only: [:new, :create]
  resources :users
  delete 'log_out' => 'sessions#destroy'
  get 'sent_index' => 'messages#sent_index'
  delete 'unfriend' => 'friends#destroy'
  delete 'block' => 'blocks#destroy'

	root 'home#index'  
end
