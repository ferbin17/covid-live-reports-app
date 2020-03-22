class District < ApplicationRecord
  has_many :stats_reports
  belongs_to :state
  validates_presence_of :name, :state_id
end
