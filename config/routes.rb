Rails.application.routes.draw do
  root 'welcome#index'

  resources :users, only: [:index, :show]

  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "users", only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  namespace 'log' do
    resources :posts do
      resources :comments, only: [:create, :destroy]
    end

    resources :editions, only: [:index, :new, :create, :destroy]
  end

  resources :articles, path: 'news', except: [:show]

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "users#new", as: "sign_up"

  get '/welcome/news' => 'welcome#news'
  get '/welcome/log' => 'welcome#log'
end
