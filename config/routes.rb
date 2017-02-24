Rails.application.routes.draw do
  resources :friends
  resources :messages
  resources :sessions, only: [:new, :create]
  resources :users
  delete 'log_out' => 'sessions#destroy'
  get 'sent_index' => 'messages#sent_index'

	root 'home#index'  
end
