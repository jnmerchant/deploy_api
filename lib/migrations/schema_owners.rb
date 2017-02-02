require_relative 'test_environment'

class CreateOwnersTable < ActiveRecord::Migration[5.0]
  def up
    create_table :owners do |owner|
      owner.string :first_name
      owner.timestamps
    end
  end

  def down
    drop_table :owners
  end
end

def main
  action = (ARGV[0] || :up).to_sym

  CreateOwnersTable.migrate(action)
end

main if __FILE__ == $PROGRAM_NAME
