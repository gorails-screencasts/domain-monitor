# Below are the routes for madmin
namespace :madmin do
  resources :users
  resources :domains
  resources :sessions

  namespace :pay do
    namespace :stripe do
      resources :charges
      resources :customers
      resources :payment_methods
      resources :subscriptions
    end

    resources :webhooks
  end

  root to: "dashboard#show"
end
