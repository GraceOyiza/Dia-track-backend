Rails.application.routes.draw do
  default_url_options :host => "http://localhost:3000"

  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth', defaults: { format: :json }
      resources :readings, defaults: { format: :json }
      resources :measures, only: [:index, :create], defaults: { format: :json }
      get '/me', to: "users#show", defaults: { format: :json }
    end
  end
  get '*path', to: 'not_found#default', defaults: { format: :json }
end
