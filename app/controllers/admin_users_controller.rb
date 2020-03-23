class AdminUsersController < ApplicationController
  
  def dashboard
    @stats_counts = StatsReport.sum_values
  end
  
  def detailed_report
    @stats_counts = StatsReport.sum_values.select('district_id').group(:district_id)
  end
  
  def manage_district_or_state
  end
  
end
