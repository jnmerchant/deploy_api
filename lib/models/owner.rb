require 'active_record'

class Owner < ActiveRecord::Base
  validates :first_name, presence: true
  has_many :pets

  scope :first_name, -> (first_name) { where("first_name ILIKE ?", "%#{first_name}%") }
end
