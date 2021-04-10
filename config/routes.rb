Rails.application.routes.draw do
  devise_for :admins
  devise_for :members
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  scope module: :public do

    root to: "homes#top"
    get     "/about" => "homes#about"
    
  end

  namespace :admin do
    get "/" => "homes#top"
    resources :works
    resources :genres,only: [:index, :edit, :create, :update, :destroy]
    resources :members,only: [:index, :show, :edit, :update, :destroy]
  end
  
  
end