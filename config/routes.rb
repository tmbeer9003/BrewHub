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
  end

  root 'public/homes#top'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
