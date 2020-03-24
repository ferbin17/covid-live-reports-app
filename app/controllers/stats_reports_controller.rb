class StatsReportsController < ApplicationController
  
  skip_before_action :verify_authenticity_token, only: [:destroy]
  respond_to :html, :js
  
  def index
    redirect_to :controller => "admin_users", :action => "detailed_report"
  end
  
  def new
    @districts = District.all
    @stats_report = StatsReport.new
  end
  
  def create
    @stats_report = StatsReport.new(construct_params)
    if @stats_report.save
      flash[:notice] = "Data added"
      redirect_to :controller => "admin_users", :action => "detailed_report"
    else
      @districts = District.all
      respond_to :js
    end
  end
  
  def edit
    @districts = District.all
    @stats_report = StatsReport.find_by_id(params[:id])
  end
  
  def update
    @stats_report = StatsReport.find_by_id(params[:id])
    if @stats_report.present?
      if @stats_report.update(construct_params)
        flash[:notice] = "Data updated"
        redirect_to :controller => "admin_users", :action => "detailed_report"
      else
        @districts = District.all
        respond_to :js
      end
    end
  end
  
  def destroy
    @stats_report = StatsReport.find_by_id(params[:id])
    if @stats_report.present?
      flash[:notice] = "Data removed" if @stats_report.destroy
      #write before destroy
    end
  end
  
  def view_removed_data
  end
  
  protected
    def construct_params
      constructed_params = params.require(:stats_report).permit(:date, :district_id, :total_no_patients, :no_of_patients_under_observation, :no_of_patients_obs_at_home, :no_of_patients_obs_at_hospital, :no_of_patients_admitted_today, :no_of_patients_recovered_today, :no_of_patients_died_today)
      constructed_params[:no_of_patients_under_observation] = constructed_params[:no_of_patients_obs_at_home].try(:to_i) + constructed_params[:no_of_patients_obs_at_hospital].try(:to_i)
      constructed_params[:total_no_patients] = constructed_params[:no_of_patients_under_observation].try(:to_i) + constructed_params[:no_of_patients_admitted_today].try(:to_i)
      constructed_params
    end
      
end
