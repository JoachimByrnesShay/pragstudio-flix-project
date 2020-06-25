# frozen_string_literal: true

Rails.application.routes.draw do
  resources :genres
  resources :users 
  resources :admin
  root 'movies#index'
  # get "movies"=>"movies#index"
  # get "movies/new" => "movies#new"
  # get "movies/:id"=>"movies#show", as: 'movie'
  # get "movies/:id/edit"=>"movies#edit", as: 'edit_movie'
  # patch "movies/:id" => "movies#update"
  get "movies/filter/:filter" => "movies#index", as: :filter_movie
  resources :movies do
    resources :reviews
    resources :favorites, only: [:create, :destroy]
  end
  get 'signup' => 'users#new'
  resource :session, only: %i[new create destroy]
  get 'signin' => 'sessions#new'

  get '*path' => redirect('/')
end
