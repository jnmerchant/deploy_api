require 'rspec'
require_relative '../lib/migrations/test_environment.rb'
require_relative '../lib/models/owner.rb'

describe Owner do
  describe '#valid?' do
    context 'when a owner has a name' do
      it 'returns true' do
        owner = Owner.new(name: 'David')

        expect(owner.valid?).to eq true
      end
    end
  end

    # context 'when a owner does not have a name' do
    #   it 'returns false' do
    #     owner = Owner.new(name: '')
    #
    #     expect(owner.valid?).to eq false
    #   end
    # end
  #
  # describe '#create' do
  #   it 'returns a Owner object with an id' do
  #     owner = Owner.create(name: 'Horace')
  #
  #     expect(owner.id > 0).to eq true
  #   end
  # end
  #
  # describe '#victims' do
  #   it 'returns victims' do
  #     owner = Owner.create(name: 'Horse-Dagger', kind: 'melee')
  #     Victim.create(name: 'Bert', owner: owner)
  #     Victim.create(name: 'Bruce', owner: owner)
  #
  #     expect(owner.victims.length).to eq 2
  #     expect(owner.victims.first.name).to eq 'Bert'
  #     expect(owner.victims.last.name).to eq 'Bruce'
  #   end
  # end
end
