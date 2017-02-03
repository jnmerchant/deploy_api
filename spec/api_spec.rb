require 'rack/test'
require_relative '../api_owner'
require 'pry'

describe 'api' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  describe '#get /owners' do
    it 'returns all owners' do
      get '/owners'

      expect(JSON.parse(last_response.body).first['first_name']).to eq 'Horace'
    end
  end

  describe '#get /owners/:id' do
    context 'when a valid owner id is entered' do
      it 'return an owner' do
        get '/owners/2'

        expect(JSON.parse(last_response.body)['first_name']).to eq 'Horace'
      end
    end

    context 'when an invalid owner id is entered' do
      it 'returns a not found status 404' do
        get '/owners/999'

        # binding.pry
        expect(last_response.status).to eq 404
      end
    end
  end

  # describe '# get /owners/sort' do
  #   context 'when a sort field is entered' do
  #     it 'returns all owners sorted by field' do
  #       get '/owners/sort/first_name'
  #       binding.pry
  #       expect(JSON.parse(last_response.body).first['first_name']).to eq 'Carl'
  #     end
  #   end
  # end

  describe '#post /owners' do
    context 'creating valid owner' do
      it 'creates new owner' do
        post '/owners?first_name=Carl'

        expect(JSON.parse(last_response.body)['first_name']).to eq 'Carl'
      end
    end
  end
  #
  #   describe '#patch /api/victims/:id/:name' do
  #     context 'give valid id and new name' do
  #       it 'updates just the name' do
  #         patch '/api/victims/1/jeff'
  #
  #         expect(JSON.parse(last_response.body)['name']).to eq 'jeff'
  #       end
  #     end
  #   end
  #
  describe '#delete /owners/:id' do
    context 'give valid id' do
      it 'deletes the owner with that id' do
        delete '/owners/1'

        expect(Owner.find_by_id(1)).to eq nil
      end
    end
  end
  # end
end
