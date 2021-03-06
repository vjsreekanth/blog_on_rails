Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

    # Home page
    get("/", { to: "posts#index", as: "root" })

    get('edit_password/:id(.:format)', {to:'users#edit_password', as: 'edit_password'})
    post('update_password/:id(.:format)', {to:'users#update_password', as: 'update_password'})

    resources :posts do
    resources :comments, only: [:create, :destroy], shallow: true
    end

    resources :users
    resource :session, only: [:new, :destroy, :create]

    namespace :admin do 
      resources :dashboard, only: [:index]
    end


end
