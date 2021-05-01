Rails.application.routes.draw do
  devise_for :admins
  devise_for :members
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  scope module: :public do

    root to: "homes#top"
    get     "/about" => "homes#about"

    resources :works, only: [:show, :index] do
      resources :reviews
      resources :forums do
        resources :comments, only: [:create]
      end
    end
    post "/works/reviews/:id" => "reviews#favorite"
    post "/works/:id/reviews/:id" => "reviews#favorite"
    post "/works/:id" => "works#category_create"
    post "/forums/:id" => "forums#favorite"

    get     "/mypages/with_tag"           => "mypages#with_tag", as: 'with_tag'
    get     "/mypages/favorite_forum"     => "mypages#favorite_forum", as: 'favorite_forum'
    post    "/mypages/tag"                => "mypages#tag", as: 'tag'
    get     "/members/delete_check"       => "mypages#delete_check", as: 'delete_check'
    patch   "/members/delete"             => "mypages#delete", as: 'delete'
    resources :mypages


    resources :work_mngs,only: [:index, :destroy, :update]

  end

  namespace :admin do
    get "/" => "homes#top"

    resources :works do
      collection do
        get "new_2"
        post "new_2"
        get "new_2_1"
        post "new_2_1"
        get "new_3"
        post "new_3"
        get "new_3_1"
        post "new_3_1"
        get 'new_confirm'
        post 'new_confirm'

        get "edit_2"
        post "edit_2"
        get "edit_2_1"
        post "edit_2_1"
        get "edit_3"
        post "edit_3"
        get "edit_3_1"
        post "edit_3_1"
        get 'edit_confirm'
        post 'edit_confirm'

        delete "actors/:id" => "work#destroy"
      end
    end

    resources :genres,only: [:index, :create, :destroy]
    resources :actors,only: [:index, :create, :destroy]
    resources :members,only: [:index, :show, :edit, :update, :destroy]
  end

end