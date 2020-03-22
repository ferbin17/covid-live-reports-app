Rails.application.routes.draw do
  devise_for :admin_users
  resources :stats_reports
  get "admin_users/detailed_report" => "admin_users/detailed_report", :as => :detailed_reports_page
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'admin_users#dashboard'
end
