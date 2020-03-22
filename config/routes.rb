Rails.application.routes.draw do
  devise_for :admin_users
  as :admin_user do
    get 'signup', to: 'devise/sessions#new'
  end
  resources :stats_reports
  get "admin_users/detailed_report" => "admin_users/detailed_report", :as => :detailed_reports_page
  get "admin_users/add_or_update_data" => "admin_users/add_or_update_data", :as => :add_or_update_data
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'admin_users#dashboard'
end
