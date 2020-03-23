class AdminUsersController < ApplicationController
  
  def dashboard
    @stats_counts = StatsReport.sum_values
  end
  
  def detailed_report
    @last_entry = StatsReport.last
    @stats_counts = StatsReport.sum_values.select('district_id').group(:district_id)
  end
  
  def data_center
    @previous_entries = StatsReport.paginate(:page => params[:page]).order(:id)
  end
  
  def manage_district_or_state
  end
  
end
