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

get '/owners' do
  owners = Owner.all
  owners.to_json
end

get '/owners/sort/:sort' do
  sort = params['sort'] || 'id'
  Owner.order(sort).to_json
end

get '/owners/:id' do |id|
  owner = Owner.find_by_id(id)
  halt(404, {message: "Owner not found"}.to_json) unless owner
  owner.to_json
end

post '/owners' do
  owner = Owner.new(first_name: params[:first_name])
  if owner.valid?
    owner.save
    [201, owner.to_json]
  else
    status 400
  end
end

put '/owners/:id' do |id|
  owner = Owner.find(id)
  existing_desc = owner.first_name
  halt(404, { message:'Owner not found'}.to_json) unless owner
  owner.update(first_name: params[:first_name])
  owner.to_json
end

delete '/owners/:id' do |id|
  if ! Owner.exists?(id)
    status 404
  else
    Owner.destroy(id)
  end
end
