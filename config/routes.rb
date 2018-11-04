Rails.application.routes.draw do
  get "/" => "home#index", :as => "root"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
