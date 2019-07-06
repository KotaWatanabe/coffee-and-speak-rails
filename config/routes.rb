Rails.application.routes.draw do
  post '/rate' => 'rater#create', :as => 'rate'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :teachers
      resource :session, only: [:create, :destroy]
      resources :users, only: [:create] do
        # /api/v1/users/current
        get :current, on: :collection
      end
    end
  end
  
  
  
  
  get("/", {to: "home#index", as: "root"})
  resources :users, only:[:new, :edit, :update, :create] do
    member do 
      get :change_password
      patch :update_password
      get :dashboard
    end
  end

  resource :session, only:[:new, :create, :destroy]

  resources :teachers do
    resources :favourites, shallow: true, only: [:create, :destroy]
    member do 
      get :teacher_dashboard
    end
    resources :reviews, shallow: true, only: [:create, :destroy] do
    end
  end
  resources :lessons,only:[:create, :destroy, :show, :edit, :update] do
    member do
      put :request
      put :approve
      put :decline
      put :pay
      put :finish
      put :done
    end
    resources :payments, only: [:new, :create] do
      member do
        get :thanks
      end
    end
  end
  
end
