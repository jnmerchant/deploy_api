require 'active_record'

class Pet < ActiveRecord::Base
  validates :name, :kind, :age, :owner, presence: true
  belongs_to :owner
end
