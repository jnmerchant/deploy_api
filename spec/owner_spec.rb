require 'rspec'
require_relative '../lib/migrations/test_environment.rb'
require_relative '../lib/models/owner.rb'
require_relative '../lib/models/pet.rb'

describe Owner do
  describe '#valid?' do
    context 'when a owner has a name' do
      it 'returns true' do
        owner = Owner.new(name: 'David')

        expect(owner.valid?).to eq true
      end
    end

    context 'when a owner does not have a name' do
      it 'returns false' do
        owner = Owner.new(name: '')

        expect(owner.valid?).to eq false
      end
    end
  end

  describe '#create' do
    it 'returns a Owner object with an id' do
      owner = Owner.create(name: 'Horace')

      expect(owner.id > 0).to eq true
    end
  end

  describe '#pets' do
    it 'returns pets' do
      owner = Owner.create(name: 'Horace')
      Pet.create(name: 'Dagger', kind: 'horse', age: 20, owner: owner)
      Pet.create(name: 'Ax', kind: 'dog', age: 5, owner: owner)

      expect(owner.pets.length).to eq 2
      expect(owner.pets.first.name).to eq 'Dagger'
      expect(owner.pets.last.name).to eq 'Ax'
    end
  end
end
