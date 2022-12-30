Rails.application.routes.draw do

  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  
  # devise_scope :admin do
  #   root "admin#sessions#new"
  # end

  namespace :admin do
     resources :customers, only: [:index,:show,:edit,:update,:destroy]
     resources :reports, only: [:index, :show, :update]
  end


  # ゲストログイン用
  devise_scope :customer do
    post 'customers/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about', as: 'about'
    get 'customers/confirm' => "customers#confirm", as: 'confirm'
    patch 'customers/withdraw' => 'customers#withdraw', as: 'withdraw'
    resources :chat_rooms, only: [:index]
    resources :chats, only: [:show, :create, :destroy]
    
    resources :customers do
      resources :reports, only: [:new, :create]
      member do
        get :favorites
      end
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end
    resources :posts do
      resources :comments, only: [:create,:destroy]
      resource :favorites, only: [:create, :destroy]
    end
    resources :notifications, only: [:index,:update]
  end

end

