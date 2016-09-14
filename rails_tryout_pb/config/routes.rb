Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
	devise_for :users
	
	root 'home#index'
  
	get 'news', to: 'news#index', defaults: {format: :json}
	get 'news/:id', to: 'news#show', defaults: {format: :json}

	get 'homework/:id', to: 'homework#start'
	get 'homework/:id/question/:question_id', to: 'homework#next'
end
