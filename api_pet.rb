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

post '/pets' do
   new_pet = Pet.new
   new_pet.name = params[:name]
   new_pet.kind = params[:kind]
   new_pet.age = params[:age]
   new_pet.owner_id = params[:owner_id]
   new_pet.save
   redirect('/')
 end

get '/pets/:id/edit'  do
  pet = Pet.find(params[:id])
  erb(:edit_pet, locals: { pet: pet })
end

put '/pets/:id' do
  pet = Pet.find(params[:id])
  pet.name = params[:name]
  pet.kind = params[:kind]
  pet.age = params[:age]
  pet.save
  redirect('/')
end

delete '/pets' do
   pet_to_delete = Pet.find(params[:pet_id])
   pet_to_delete.destroy
   redirect('/')
 end
