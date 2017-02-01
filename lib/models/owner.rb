require 'active_record'

class Owner < ActiveRecord::Base
  validates :name, presence: true
  has_many :pets
end
