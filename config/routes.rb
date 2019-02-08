# frozen_string_literal: true

Rails.application.routes.draw do
  resources :posts
  mount_devise_token_auth_for 'User', at: 'auth'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: %i[index show] do
    member do
      put :request_friend
    end
    collection do
      get :pending_friends
    end
  end
end
