class StatsReport < ApplicationRecord
  belongs_to :district
  validates_presence_of :date, :district_id
  validate :check_for_atleast_one_data

  scope :sum_values, -> { select('sum(total_no_patients) as total_count_of_patients, sum(no_of_patients_under_observation) as count_of_patients_under_obs, sum(no_of_patients_obs_at_home) as count_of_patients_at_homes, sum(no_of_patients_obs_at_hospital) as count_of_patients_at_hospitals, sum(no_of_patients_admitted_today) as admitted_today, sum(no_of_patients_recovered_today) as total_recovered, sum(no_of_patients_died_today) as total_died') }
  scope :final_report, -> { select('sum(total_no_patients) total_patients,sum(no_of_patients_under_observation) total_obs,sum(no_of_patients_obs_at_home) total_obs_home, sum(no_of_patients_obs_at_hospital) total_obs_hospital, sum(no_of_patients_died_today) died')[0] }
  
  scope :group_by_district, -> { select('district_id, sum(total_no_patients) total_no_patients, sum(no_of_patients_under_observation) no_of_patients_under_observation, sum(no_of_patients_obs_at_home) no_of_patients_obs_at_home, sum(no_of_patients_obs_at_hospital) no_of_patients_obs_at_hospital, sum(no_of_patients_admitted_today) no_of_patients_admitted_today, sum(no_of_patients_recovered_today) no_of_patients_recovered_today, sum(no_of_patients_died_today) no_of_patients_died_today').group(:district_id) }
  scope :filter_by_date, -> (start_date, end_date) { where(date: start_date..end_date)}

  def check_for_atleast_one_data
    if no_of_patients_under_observation.zero? &&
       no_of_patients_obs_at_home.zero? && no_of_patients_obs_at_hospital.zero? &&
       no_of_patients_admitted_today.zero? && no_of_patients_recovered_today.zero? &&
       no_of_patients_died_today.zero?
      errors.add(:base, :enter_atleast_one_data)
    end
  end

  def self.fetch_report(params)
    district_ids = params[:district_id]
    start_date = params[:start_date]
    end_date = params[:end_date].present? ? params[:end_date] : Date.today
    report = StatsReport.where(district_id: district_ids)
    report = report.filter_by_date(start_date, end_date) if params[:start_date].present?
    report = report.group_by_district if params[:type] == "district_wise"
    return report
  end
end
