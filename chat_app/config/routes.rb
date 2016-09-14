Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  #mount ActionCable.server => '/cable'

  root 'apps#index'

  resource  :session
  resources :apps

  resources :messages

  resources :apps do
    resources :messages
  end

  get 'admin/app/:app_id', to: 'admin#app' 
  get 'admin/app/:app_id/conversation/:conversation_id', to: 'admin#conversation' 
 end
