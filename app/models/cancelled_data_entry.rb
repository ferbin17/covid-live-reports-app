class CancelledDataEntry < ApplicationRecord
  belongs_to :district
  belongs_to :admin_user
  
  validates_presence_of :date, :district_id
  validate :check_for_atleast_one_data
  
  self.per_page = 5
  
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
