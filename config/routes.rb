Rails.application.routes.draw do  
  namespace :api, defaults: { format: 'json' } do
    get '/bikeway_networks', to: 'bikeway_networks#nearest_network'
    resources :sf311_case_metadata, only: [:index]
    resources :sf311_cases, only: [:index, :create]
  end
end
