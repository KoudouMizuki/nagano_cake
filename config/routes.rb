Rails.application.routes.draw do

  devise_for :customers,skip: [:password], controllers:{
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin,skip: [:registrations,:password], controllers:{
    sessions: "admin/sessions"
  }

  scope module: :public do
    root to: "homes#top"
    get 'homes/about' => "homes#about", as: 'about'
    get 'customers/mypage' => 'customers#show'
    get 'customers/mypage/edit' => 'customers#edit'
    patch 'customers/mypage/edit' => 'customers#update'
    get 'customers/mypage/edit/confirm' => 'customers#confirm'
    patch 'customers/withdraw' => 'customers#withdraw'

    resources :addresses, only: [:index, :create, :edit, :update, :destroy]
    resources :items, only: [:index, :show]
    resources :cart_items, only: [:index, :create, :update, :destroy] do
      collection do
        delete "all_destroy"
      end
    end
    get 'orders/thanx' => 'orders#thanx'
    resources :orders, only: [:new, :create, :index, :show]
    post 'orders/confirm' => 'orders#confirm'


  end

  namespace :admin do
   root to: "homes#top"
    resources :customers, only: [:index, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :orders, only: [:show, :update]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
