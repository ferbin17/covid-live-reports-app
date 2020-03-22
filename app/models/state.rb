class State < ApplicationRecord
  has_many :districts
  belongs_to :country
  validates_presence_of :name, :country_id
end
