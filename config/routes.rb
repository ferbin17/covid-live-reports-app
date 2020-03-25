Rails.application.routes.draw do
  devise_for :admin_users
  resources :stats_reports
  resources :reports
  get "admin_users/detailed_report" => "admin_users/detailed_report", :as => :detailed_reports_page
  post "reports/view_report"

  root 'admin_users#dashboard'
end
