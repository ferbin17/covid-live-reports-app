class AdminUsersController < ApplicationController
  
  def dashboard
    @stats_counts = StatsReport.select('sum(total_no_patients) as total_count_of_patients, sum(no_of_patients_under_observation) as count_of_patients_under_obs, sum(no_of_patients_obs_at_home) as count_of_patients_at_homes, sum(no_of_patients_obs_at_hospital) as count_of_patients_at_hospitals, sum(no_of_patients_admitted_today) as admitted_today')
  end
  
  def detailed_report
    @stats_counts = StatsReport.all.select('sum(total_no_patients) as total_count_of_patients, sum(no_of_patients_under_observation) as count_of_patients_under_obs, sum(no_of_patients_obs_at_home) as count_of_patients_at_homes, sum(no_of_patients_obs_at_hospital) as count_of_patients_at_hospitals, sum(no_of_patients_admitted_today) as admitted_today, district_id').group(:district_id)
  end
  
  def manage_district_or_state
  end
  
end
