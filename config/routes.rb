Rails.application.routes.draw do
  get "home/index"

  devise_for :users, controllers: { 
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  devise_scope :user do
    get  'users/edit_account',   to: 'users/registrations#edit_account',   as: :edit_account_user
    put  'users/update_account', to: 'users/registrations#update_account', as: :update_account_user

    get  'users/edit_profile',   to: 'users/registrations#edit_profile',   as: :edit_profile_user
    put  'users/update_profile', to: 'users/registrations#update_profile', as: :update_profile_user
  end

  root "home#index"

  get "/account", to: "users#show_account", as: :account
  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  get 'my_rooms', to: 'rooms#my_rooms'
  # 予約一覧（自分の予約だけ表示）
  get 'my_reservations', to: 'reservations#my_reservations', as: :my_reservations

  resources :rooms do
    resources :reservations
  end

  resources :reservations do
    collection do
      post 'confirm'
    end
  end
end