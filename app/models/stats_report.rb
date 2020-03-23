class StatsReport < ApplicationRecord
  belongs_to :district
  validates_presence_of :date, :district_id
  validate :check_for_atleast_one_data
  
  scope :sum_values, -> { select('sum(total_no_patients) as total_count_of_patients, sum(no_of_patients_under_observation) as count_of_patients_under_obs, sum(no_of_patients_obs_at_home) as count_of_patients_at_homes, sum(no_of_patients_obs_at_hospital) as count_of_patients_at_hospitals, sum(no_of_patients_admitted_today) as admitted_today, sum(no_of_patients_recovered_today) as total_recovered, sum(no_of_patients_died_today) as total_died') }
  
  self.per_page = 10
  
  def check_for_atleast_one_data
    if((self.no_of_patients_under_observation == 0 || self.no_of_patients_under_observation.nil?) && 
      (self.no_of_patients_obs_at_home == 0 || self.no_of_patients_obs_at_home.nil?) && 
      (self.no_of_patients_obs_at_hospital == 0 || self.no_of_patients_obs_at_hospital.nil?) &&
      (self.no_of_patients_admitted_today == 0 || self.no_of_patients_admitted_today.nil?) && 
      (self.no_of_patients_recovered_today == 0 || self.no_of_patients_recovered_today.nil?) &&
      (self.no_of_patients_died_today == 0 || self.no_of_patients_died_today.nil?))
      self.errors.add(:base, :enter_atleast_one_data)
    end
  end
end
