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

get '/' do
   owners = Owner.all
   erb(:index, locals: { owners: owners } )
 end

get '/owners/create' do
 erb(:create_owner)
end

post '/owners' do
  new_owner = Owner.new
  new_owner.first_name = params[:first_name]
  new_owner.save
  redirect '/'
end

get '/owners/:id/edit' do
  owner = Owner.find(params[:id])
  erb(:edit_owner, locals: { owner: owner } )
end

put '/owners/:id' do
  owner = Owner.find(params[:id])
  owner.first_name = params[:first_name]
  owner.save
  redirect '/'
end

delete('/owners/:id') do
  owner = Owner.find(params[:id])
  if owner.pets.count > 0
    redirect '/'
  else
   owner.destroy
  end
  redirect '/'
end
