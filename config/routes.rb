Rails.application.routes.draw do
   match '/login', to: 'users#login', via: [:post, :options]

  get "home/index"
  get "/products", to: "products#index"
  get "/shops", to: "shops#index"
  get "/shop/:id", to: "shops#show"
  post "/shops", to: "shops#create"
  get "/product/:id", to: "products#show"
  post "product",to: "products#create"
  # delete "/shop",to: "shop#delete"

  get "/users", to: "users#index"
  post "/send_otp", to: "users#send_otp"
  post "/create_user", to: "users#create"
  post "/login", to: "users#login"
  # singles routes
  post "/create_singles", to: "singles#create"
  get "singles/my_singles", to: "singles#my_singles"
  get "singles/by_broker/:broker_number", to: "singles#index"

  

  # root "users#index"
  root "home#index"
devise_for :users, controllers: {
  omniauth_callbacks: 'users/omniauth_callbacks'
}
devise_scope :user do
  get '/users/auth/failure', to: 'users/omniauth_callbacks#failure'
end
get '/users/auth/failure', to: 'users/omniauth_callbacks#failure'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
resources :students
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
