Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  resources :users, only: [:index, :show, :create, :new] do
    collection do
      get '/activate' => 'users#user_activation', as: :activate
    end
  end

  scope :mailgun do
    post '/open' => 'mailgun_webhook#message_open'
    post '/click' => 'mailgun_webhook#message_click'
    post '/bounce' => 'mailgun_webhook#message_bounce'
  end

  require 'sidekiq/web'
  mount Sidekiq::Web => '/admin/sidekiq'
end
