Rails.application.routes.draw do
  resources :discussions

  post 'discussion/post' => 'lecture_recordings#create_discussion'
  get 'lecture_recordings/discussions/:id' => 'lecture_recordings#get_discussions', as: 'discussions_json'

  resources :lecture_recordings

  root to: 'visitors#index'
  devise_for :users
  resources :users
end
