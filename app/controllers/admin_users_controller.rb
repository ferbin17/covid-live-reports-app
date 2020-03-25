class AdminUsersController < ApplicationController
  
  def dashboard
    @stats_counts = StatsReport.sum_values
  end
  
  def detailed_report
    @countries = Country.all
    @states = []
    @last_entry = StatsReport.last
  end
  
  def data_center
    @previous_entries = StatsReport.paginate(:page => params[:page]).order(id: :desc)
  end
  
  def manage_district_or_state
  end
  
end
