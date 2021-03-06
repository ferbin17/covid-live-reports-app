Rails.application.routes.draw do
  devise_for :admin_users, skip: [:registrations]
  as :admin_user do
  get 'edit', to: 'devise/registrations#edit', as: :edit_admin_user_registration
  patch '/', to: 'devise/registrations#update', as: :admin_user_registration
  put '/', to: 'devise/registrations#update', as: :admin_user_registration_update
  delete '/', to: 'devise/registrations#destroy', as: :destroy_user_account
end
  resources :stats_reports
  resources :reports do
    get :report_pdf, on: :collection
  end
  resources :import_csv_logs do
    get :csv_export, on: :collection
  end
  
  #admin_users
  get "admin_users/detailed_report" => "admin_users/detailed_report", :as => :detailed_reports_page
  get "admin_users/data_center" => "admin_users/data_center", :as => :data_center
  
  #stats_reports
  post "stats_reports/get_states" => "stats_reports/get_states", :as => :get_states
  post "stats_reports/view_records_data" => "stats_reports/view_records_data", :as => :view_records_data
  post "stats_reports/get_states_for_forms" => "stats_reports/get_states_for_forms", :as => :get_states_for_forms
  post "stats_reports/get_districts_for_froms" => "stats_reports/get_districts_for_froms", :as => :get_districts_for_froms
  post "stats_reports/view_removed_data" => "stats_reports/view_removed_data", :as => :view_removed_data

  
  #reports
  post "reports/view_report"
  
  #import csv
  post "import_csv_logs/get_import_form" => "import_csv_logs/get_import_form", :as => :get_import_form
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'admin_users#dashboard'
end
