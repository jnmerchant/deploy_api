class CreatePetsTable < ActiveRecord::Migration[5.0]
  def up
    create_table :pets do |pet|
      pet.string :name
      pet.string :kind
      pet.integer :age
      pet.belongs_to :owner, foreign_key: 'owner.id'
      pet.timestamps
    end
  end

  def down
    drop_table :pets
  end
end
