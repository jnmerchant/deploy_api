require_relative 'environment'

class CreatePetsTable < ActiveRecord::Migration[5.0]
  def up
    create_table :pets do |pet|
      pet.string :name
      pet.string :type
      pet.integer :age
      pet.belongs_to :owner, :foreign_key => 'owner.id'
      pet.timestamps
    end
  end

  def down
    drop_table :pets
  end
end

def main
  action = (ARGV[0] || :up).to_sym

  CreatePetsTable.migrate(action)
end

main if __FILE__ == $PROGRAM_NAME
