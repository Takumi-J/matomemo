Rails.application.routes.draw do
  # devise_for :admins
  # devise_for :members
    devise_for :admins, controllers: {
  sessions:      'admins/sessions',
  passwords:     'admins/passwords',
  registrations: 'admins/registrations'
}
    devise_for :members, controllers: {
  sessions:      'members/sessions',
  passwords:     'members/passwords',
  registrations: 'members/registrations'
}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  


  scope module: :public do

    root to: "homes#top"
    get     "/about" => "homes#about"

    resources :works, only: [:show, :index] do
      resources :reviews
      post "/forums/:id" => "forums#favorite"
      resources :forums do
        resources :comments, only: [:create]
      end
    end

    post "/works/reviews/:id" => "reviews#favorite"
    post "/works/:id/reviews/:id" => "reviews#favorite"
    post "/works/:id" => "works#category_create"

    get     "/mypages/with_tag"           => "mypages#with_tag", as: 'with_tag'
    get     "/mypages/favorite_forum"     => "mypages#favorite_forum", as: 'favorite_forum'
    post    "/mypages/tag"                => "mypages#tag", as: 'tag'
    get     "/members/delete_check"       => "mypages#delete_check", as: 'delete_check'
    patch   "/members/delete"             => "mypages#delete", as: 'delete'
    get     "/members/follow"             => "mypages#follow_index", as: 'follow_index'
    get     "/members/follow_review"      => "mypages#follow_review", as: 'follow_review'

    resources :mypages

    get     "/others/with_tag"           => "others#with_tag", as: 'with_tag_others'
    resources :others

    resources :work_mngs,only: [:index, :destroy, :update]

    resources :actors, only: [:index]
    get     "/actors/:id"           => "actors#actor_works", as: 'actor_works'

    resources :genres, only: [:index]
    get     "/genres/:id"           => "genres#genre_works", as: 'genre_works'
    
    resources :relationships, only: [:create, :destroy]
    
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
      resources :reviews,only: [:index,:destroy]
      resources :forums,only: [:index,:show,:destroy]
    end

    resources :genres,only: [:index, :create, :destroy]
    resources :actors,only: [:index, :create, :destroy]
    resources :members,only: [:index, :show, :edit, :update, :destroy]
  end

end