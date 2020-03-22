class StatsReportsController < ApplicationController
  
  def index
    redirect_to :controller => "admin_users", :action => "detailed_report"
  end
  
  def new
    @districts = District.all
    @stats_report = StatsReport.new
  end
  
  def create
    @stats_report = StatsReport.new(permit_params)
    if @stats_report.save
      redirect_to :controller => "admin_users", :action => "detailed_report"
    else
      @districts = District.all
      render 'new'
    end
  end
  
  def permit_params
    params.require(:stats_report).permit(:date, :district_id, :total_no_patients, :no_of_patients_under_observation, :no_of_patients_obs_at_home, :no_of_patients_obs_at_hospital, :no_of_patients_admitted_today)
  end
end
