class StatsReport < ApplicationRecord
  belongs_to :district
  validates_presence_of :date, :district_id
  validate :check_for_atleast_one_data
  
  def check_for_atleast_one_data
    if(self.no_of_patients_under_observation.nil? && 
      self.no_of_patients_obs_at_home.nil? && self.no_of_patients_obs_at_hospital.nil? &&
        self.no_of_patients_admitted_today.nil?)
      self.errors.add(:base, :enter_atleast_one_data)
    end
  end
end
