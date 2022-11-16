Rails.application.routes.draw do

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    resources :beer_styles, except: [:new, :edit, :show]
    post 'beer_styles/:id' => 'beer_styles#edit'
    resources :breweries, except: [:new, :edit]
  end

  devise_for :members, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  scope module: :public do
    resources :beers, except: [:edit, :update, :destroy]
    resources :posts do
      resource :cheer, only:[:create, :destroy]
      resources :post_comments, only:[:create, :destroy]
    end
    resources :bars, only: [:create]
    resources :shops, only: [:create]
    resources :members, except: [:new, :create, :destroy] do
      resource :relationship, only: [:create, :destroy]
      get 'followings'=> 'relationships#followings'
      get 'followers'=> 'relationships#followers'
    end
    get 'mypage'=> 'homes#timeline'
    get 'mypage/cheers_list'=> 'homes#cheers_list'
  end

  root 'public/homes#top'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
