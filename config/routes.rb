require 'sidekiq/web'
require 'sidekiq/cron/web'

unless Rails.env.development?
  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username), ::Digest::SHA256.hexdigest(ENV['SIDEKIQ_USERNAME'])) &
      ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest(ENV['SIDEKIQ_PASSWORD']))
  end
end

Rails.application.routes.draw do
  mount Sidekiq::Web, at: '/sidekiq'

  root :to => proc {
    [
      200,
      { "Content-Type" => "text/html" },
      ['Welcome to Lane Breach\'s api. Learn more at https://github.com/lanebreach/lanebreach-api.']
    ]
  }

  post "/graphql", to: "graphql#execute"

  namespace :api, defaults: { format: 'json' } do
    get '/bikeway_networks', to: 'bikeway_networks#nearest_network'

    resources :sf311_case_metadata, only: [:index]
    resources :sf311_cases, only: [:index, :create]
    resources :bikeway_networks, only: [:index, :show]
    resources :sf_mta_ridership_counts, only: [:index]
    resources :users, only: [:show, :create, :update]
    resources :case_requests, only: [:create] do
      get :counts, on: :collection
    end
    
  end
end
