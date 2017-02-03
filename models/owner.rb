require 'active_record'

class Owner < ActiveRecord::Base
  validates :first_name, presence: true
  has_many :pets
end
