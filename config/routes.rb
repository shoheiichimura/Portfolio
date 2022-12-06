Rails.application.routes.draw do
  namespace :public do
    get 'relationships/followings'
    get 'relationships/followers'
  end

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

  scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about', as: 'about'
    resources :customers do
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships/followings', as: 'followings'
      get 'followers' => 'relationships/followers', as: 'followers'
    end
    resources :posts do
      resources :comments, only: [:create,:destroy]
      resource :favorites, only: [:create, :destroy]
    end
  end

end
