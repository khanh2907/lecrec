Rails.application.routes.draw do
  post 'discussion/post' => 'lecture_recordings#create_discussion'
  post 'comment/post' => 'discussions#comment'

  get 'lecture_recordings/discussions/:id' => 'lecture_recordings#get_discussions', as: 'discussions_json'
  get 'lecture_recordings/render_discussions/:id' => 'lecture_recordings#render_discussions', as: 'discussions_render'

  get 'lecture_recordings/render_comments/:id' => 'discussions#render_comments', as: 'discussions_render_comments'


  resources :lecture_recordings
  resources :discussions
  resources :comments

  root to: 'visitors#index'
  devise_for :users
  resources :users
  match 'users/:id' => 'users#destroy', :via => :delete, :as => :admin_destroy_user
end
