Rails.application.routes.draw do
  default_url_options :host => "http://localhost:3000"

  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'
      resources :readings
      get '/me', to: "users#show"
    end
  end
end
