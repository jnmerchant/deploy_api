require 'sinatra'
require 'active_record'
require 'yaml'
require_relative 'models/owner'
require_relative 'models/pet'

database_config = ENV['DATABASE_URL']

if database_config.blank?
  database_config = YAML::load(File.open('config/database.yml'))
end

ActiveRecord::Base.establish_connection(database_config)

after do
  ActiveRecord::Base.connection.close
end

get '/pets' do
  pets = Pet.all
  pets.to_json
end

get '/pets/sort/:sort' do
  sort = params['sort'] || 'id'
  Pet.order(sort).to_json
end

get '/pets/:id' do |id|
  pet = Pet.find_by_id(id)
  halt(404, {message: "Pet not found"}.to_json) unless pet
  pet.to_json
end

post '/pets' do
  pet = Pet.new(name: params[:name], kind: params[:kind], age: params[:age],
    owner_id: params[:owner_id])
  if pet.valid?
    pet.save
    [201, pet.to_json]
  else
    status 400
  end
end

put '/pets/:id' do |id|
  pet = Pet.find(id)
  existing_desc = pet.name
  halt(404, { message:'Pet not found'}.to_json) unless pet
  pet.update(name: params[:name])
  pet.to_json
end

delete '/pets/:id' do |id|
  if ! Pet.exists?(id)
    status 404
  else
    Pet.destroy(id)
  end
end
