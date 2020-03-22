class StatsReportsController < ApplicationController
  
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
      redirect_to :controller => "admin_users", :action => "detailed_report"
    else
      @districts = District.all
      render 'new'
    end
  end
  
  protected
    def construct_params
      constructed_params = params.require(:stats_report).permit(:date, :district_id, :total_no_patients, :no_of_patients_under_observation, :no_of_patients_obs_at_home, :no_of_patients_obs_at_hospital, :no_of_patients_admitted_today)
      constructed_params[:no_of_patients_under_observation] = constructed_params[:no_of_patients_obs_at_home].try(:to_i) + constructed_params[:no_of_patients_obs_at_hospital].try(:to_i)
      constructed_params[:total_no_patients] = constructed_params[:no_of_patients_under_observation].try(:to_i) + constructed_params[:no_of_patients_admitted_today].try(:to_i)
      constructed_params
    end
end
