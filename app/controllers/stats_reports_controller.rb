class StatsReportsController < ApplicationController
  
  skip_before_action :verify_authenticity_token, only: [:get_states, :view_records_data, :get_states_for_forms, :get_districts_for_froms, :destroy, :view_removed_data]
  respond_to :html, :js
  
  def index
    redirect_to :controller => "admin_users", :action => "detailed_report"
  end
  
  def show
    redirect_to :controller => "admin_users", :action => "detailed_report"
  end
  
  def new
    @countries = Country.all
    @states = []
    @districts = []
    @stats_report = StatsReport.new
  end
  
  def create
    @countries = Country.all
    @country = Country.find_by_id(construct_filter_params[:country_id])
    @states = @country.states
    @state = State.find_by_id(construct_filter_params[:state_id])
    @districts = @state.districts

    @stats_report = StatsReport.new(construct_params)
    @district = @stats_report.district
    if @stats_report.save
      flash[:notice] = "Data added"
      redirect_to :controller => "admin_users", :action => "data_center"
    else
      respond_to :js
    end
  end
  
  def edit
    @stats_report = StatsReport.find_by_id(params[:id])
  end
  
  def update
    @stats_report = StatsReport.find_by_id(params[:id])
    if @stats_report.present?
      if @stats_report.update(construct_params)
        flash[:notice] = "Data updated"
        redirect_to :controller => "admin_users", :action => "data_center"
      else
        @districts = District.all
        respond_to :js
      end
    end
  end
  
  def destroy
    @stats_report = StatsReport.find_by_id(params[:id])
    if @stats_report.present?
      flash[:notice] = "Data removed and moved to cancelled updations" if @stats_report.destroy
    end
    redirect_to :controller => "admin_users", :action => "data_center", page: params[:page_no]
  end
  
  def get_states
    @states = State.where(country_id: params[:country_id])
  end
  
  def get_states_for_forms
    @states = State.where(country_id: params[:country_id])
  end
  
  def get_districts_for_froms
    state = State.find_by_id(params[:state_id])
    @districts = state.districts if state.present?
  end
  
  def view_records_data
    state = State.find_by_id(params[:state_id])
    district_ids = state.districts.collect(&:id) if state.present?
    @stats_counts = StatsReport.sum_values.select('district_id').where(district_id: district_ids).group(:district_id)
  end
  
  def view_removed_data
    @cancelled_data_entries = CancelledDataEntry.paginate(:page => params[:page]).order(id: :desc)
  end
  
  protected
    def construct_params
      constructed_params = params.require(:stats_report).permit(:date, :district_id, :total_no_patients, :no_of_patients_under_observation, :no_of_patients_obs_at_home, :no_of_patients_obs_at_hospital, :no_of_patients_admitted_today, :no_of_patients_recovered_today, :no_of_patients_died_today)
      constructed_params[:no_of_patients_under_observation] = constructed_params[:no_of_patients_obs_at_home].try(:to_i) + constructed_params[:no_of_patients_obs_at_hospital].try(:to_i)
      constructed_params[:total_no_patients] = constructed_params[:no_of_patients_under_observation].try(:to_i) + constructed_params[:no_of_patients_admitted_today].try(:to_i)
      constructed_params[:admin_user_id] = current_admin_user.id
      constructed_params
    end
    
    def construct_filter_params
      constructed_params = params.require(:filter).permit(:country_id, :state_id)
      constructed_params
    end

      
end
