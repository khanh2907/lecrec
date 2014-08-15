Rails.application.routes.draw do
  resources :lecture_recordings

  root to: 'visitors#index'
  devise_for :users
  resources :users
end
