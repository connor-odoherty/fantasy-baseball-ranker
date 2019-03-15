# frozen_string_literal: true

Rails.application.routes.draw do
  get 'sessions/new'

  root 'static_pages#home'
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources :players
  resources :user_players do
    get :autocomplete, on: :collection, action: :autocomplete
  end

  resources :pro_ranking_sets
  resources :user_ranking_sets do
    collection do
      patch :sort
    end

    resources :duel_rank
  end
  resources :user_ranking_players

  resources :users
end
