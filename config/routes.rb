Rails.application.routes.draw do
  


  mount RailsAdmin::Engine => '/fadmin', as: 'rails_admin'
  devise_for :users
  get "/" => "home#index", :as => "root"
  get "/contacts" => "home#contact"

  get "/items" => "home#item"
  get "/referee" => "home#referee"  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #mount RailsAdmin::Engine => '/fadmin', as: 'rails_admin'
  resources :team, only: [:index, :show]
  resources :table, only: [] do
    member do
      get 'team_position'
      get 'match_result'
      get 'goal_leader'
      get 'summary'
    end    
  end
  resources :photo, only: [:index, :show] do
    # /ost 'show_photo'
  end
  get "/futadmin/generate"=>"futadmin#generate"

  resources :doc do
    member do 
        get 'download'
    end
  end

  resources :history
  
end
