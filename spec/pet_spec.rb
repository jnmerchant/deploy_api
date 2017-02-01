require_relative '../lib/migrations/test_environment.rb'
require_relative '../lib/models/pet.rb'
require_relative '../lib/models/owner.rb'

describe Pet do
  describe '#valid?' do
    context 'when a pet has name, age, owner, but no kind' do
      it 'returns true' do
        owner = Owner.new(name: 'Fred')
        pet = Pet.new(name: 'David', kind: '', age: 2, owner: owner)

        expect(pet.valid?).to eq false
      end
    end

    # context 'when a owner does not have a name' do
    #   it 'returns false' do
    #     owner e Pet.new(name: '')
    #
    #     expect(owner.valid?).to eq false
    #   end
    # end
  end
end
