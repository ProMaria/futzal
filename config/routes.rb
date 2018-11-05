Rails.application.routes.draw do
  
  get "/" => "home#index", :as => "root"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount RailsAdmin::Engine => '/fadmin', as: 'rails_admin'
  resources :items, only: [:index, :show]
  
end
