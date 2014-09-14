require 'resque/server'
Rails.application.routes.draw do
  resources :unit_of_studies do
    resources :semesters do
      resources :lecture_recordings
    end
  end

  get 'unit_of_studies/:unit_of_study_id/semesters/:id/enrol' => 'semesters#enrol', as: 'semester_enrol'
  patch 'unit_of_studies/:unit_of_study_id/semesters/:id/enrol' => 'semesters#enrol_student'

  post 'discussion/post' => 'lecture_recordings#create_discussion'
  post 'comment/post' => 'discussions#comment'

  get 'lecture_recordings/discussions/:id' => 'lecture_recordings#get_discussions', as: 'discussions_json'
  get 'lecture_recordings/render_discussions/:id' => 'lecture_recordings#render_discussions', as: 'discussions_render'
  patch 'comments/:id/like' => 'comments#like', as: 'comment_like'

  get 'render_comments/:id' => 'discussions#render_comments', as: 'discussions_render_comments'

  resources :discussions
  resources :comments

  root to: 'visitors#index'
  devise_for :users
  resources :users
  match 'users/:id' => 'users#destroy', :via => :delete, :as => :admin_destroy_user

  mount Resque::Server.new, at: "/resque"
end
