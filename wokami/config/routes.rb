Wokami::Application.routes.draw do

  #*********************************************************
  # New Feature: Feed
  #*********************************************************

  get "/s/:id" => "subjects#feed"
  
  #*********************************************************
  # GEM Routes
  #   Rails Admin
  #   Devise
  #*********************************************************

  # get /admin: database config
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  # /users/sign_out
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" } do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end


  #*********************************************************
  # API for Angular
  #*********************************************************

  scope :api do
    #JSON of all posts in subject
    get "/subjects/:id/posts" => "subjects#get_posts"

    #JSON of all posts in chapter
    get "/subjects/:id/chapters/:chapter_id/posts" => "subjects#get_posts_by_chapter"

    #JSON of subject's chapters
    get "/subjects/:id/chapters" => "subjects#get_chapters"

    #JSON of all subjects to be shown at homepage (with field subject_type == paths)
    get "/subjects/paths" => "subjects#get_paths"
  end


  #*********************************************************
  # Specific Subjects Routes
  #
  #     the reasoning behind this is better URLS, shorter
  #     and mainly because reddit doesn't differntiate
  #     between url#data anything after #
  #     TODO: integrate Angular and get rid of # in url.
  #     should do this automatically but for speed I did this.
  #*********************************************************

  get '/s/calligraphy' => redirect("/paths#/54/chapters/86/posts/1")
  get '/s/arabiccalligraphy' => redirect("/paths#/54/chapters/86/posts/1")
  get 's/sayings' => redirect("/paths#/54/chapters/85/posts/1")

  

  #*********************************************************
  # Root: all commented because public folder includes index.html
  #*********************************************************

  #root :to => ""

  #authenticated :user do
  #  root :to => "home#featured_subjects", :as => "authenticated_root"
  #end
  
  #root :to => "home#featured_subjects"

  root :to => "home#homepage_we_moved"

  
  #*********************************************************
  # Testing Routes
  #*********************************************************

  #not used currently
  match 'subjects/upload' => 'subjects#upload_image', as: :subject_image_upload, via: [:get, :patch]

  
  #*********************************************************
  # Specific Routes
  #*********************************************************


  #match 'subjects/upload' => 'subjects#upload_image', as: :subject_image_upload, via: [:get, :patch]

  match 'search/:id' => "subjects#search", via: [:get, :post]
  #post 'search' => "subjects#search_post"

  authenticated :user do
    #previous homepage: show subjects.
    get '/homebooks' => "home#featured_subjects", :as => "authenticated_root"
  end
  
  #previous homepage: show subjects.
  get  'home/subjects' => 'home#featured_subjects'

  #previous homepage: login with facebook or email.
  get   '/oldhome' => "home#index"             #old root: login

  #show user profile, not used anymore
  get   '@:username' => 'profiles#index'

  #vote up and down: not used now
  post  'posts/vote' => 'posts#vote'

  # not used
  get   'lessons/new' => 'posts#new_lesson'
  get   'lessons/edit/:id' => 'posts#edit_lesson'
  
  

  #*********************************************************
  # Test Routes, you can play with these
  #*********************************************************

  #for tests, not used  
  get   '/home/tryout' => 'home#tryout'
  get   'subjects/angular' => 'subjects#angular'


  #*********************************************************
  # resources: most aren't sed anymore because of /admin
  #*********************************************************
  
  resources :posts
  resources :subjects
  resources :chapters
  resources :questions
  resources :answers
  resources :answer_tags
  resources :flows
  resources :flow_chapters


  #*********************************************************
  # Quizzer: no longer used
  #*********************************************************
  
  get   'quizzer/:id' => 'subjects#quizzer'
  post  'quizzer' => 'questions#next_question'


  #*********************************************************
  # /w, /s handling: no longer used
  #*********************************************************

  get 's/:subject_short_name' => 'subjects#posts'
  get 'w/:subject_short_name' => 'subjects#show_posts_all'
  get 'w/:subject_short_name/tag/:tag_name' => 'subjects#show_posts_all'
  get 'w/:subject_short_name/:chapter_name' => 'subjects#show_posts_all'
  post 'w/:subject_short_name' => 'subjects#add_post'


  #*********************************************************
  # Reference : this is to help you with making routes.
  #*********************************************************
  
  #get ':controller(/:action(/:id))'
  #post ':controller(/:action(/:id))'

  #namespace :api, defaults: {format: :json} do
  #  resources :subjects, only: [:index] do
  #    resources :chapters, only: [:index]
  #  end
  #end

  #*********************************************************
end