Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    resources :beer_styles, except: [:show]
    resources :breweries, except: [:show]
    resources :members, except: [:new, :create] do
      get "followings" => "relationships#followings"
      get "followers" => "relationships#followers"
      get "group_list" => "groups#group_list"
    end
    resources :posts, except: [:new, :create] do
      resources :post_comments, only: [:destroy]
    end
    resources :beers
    resources :bars, only: [:index, :create, :destroy]
    resources :groups, except: [:new, :create] do
      resources :group_posts, except: [:new, :create] do
        resources :group_post_comments, only: [:destroy]
      end
    end
  end

  devise_for :members, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  scope module: :public do
    resources :beers, except: [:edit, :update, :destroy]
    resources :posts do
      resource :cheer, only: [:create, :destroy]
      resources :post_comments, only: [:create, :destroy]
    end
    resources :bars, only: [:create]
    resources :members, only: [:update, :index, :show] do
      resource :relationship, only: [:create, :destroy]
      get "followings" => "relationships#followings"
      get "followers" => "relationships#followers"
    end
    resources :groups do
      resource :groups_member, only: [:create, :destroy]
      resources :group_posts do
        resources :group_post_comments, only: [:create, :destroy]
      end
    end
    devise_scope :member do
      post "guest_sign_in", to: "members/sessions#guest_sign_in"
    end
    get "mypage" => "homes#timeline"
    get "mypage/cheers_list" => "homes#cheers_list"
    get "mypage/group_list" => "homes#group_list"
    get "mypage/edit" => "members#edit"
  end

  root "public/homes#top"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
