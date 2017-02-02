require 'sinatra'
require_relative 'lib/migrations/test_environment.rb'
require_relative 'lib/models/owner.rb'
require_relative 'lib/models/pet.rb'
require 'pry'

after do
  ActiveRecord::Base.connection.close
end

get '/owners' do
  owners = Owner.all
  [:first_name].each do |filter|
    owners = owners.send(filter, params[filter]) if params[filter]
  end
  owners.to_json
end

# get '/owners/:id' do |id|
#   if id.to_i.is_a? Integer
#    owner = Owner.find_by_id(id)
#    owner.to_json
#   else
#     owners = Owner.all.order(params[sort])
#     owners.to_json
#   end
# end
# #
# post '/owners' do
#   owner = Owner.new(first_name: params[:first_name])
#   if owner.valid?
#     owner.save
#     [201, owner.to_json]
#   else
#     status 400
#   end
# end
#
# put '/owners/:id' do |id|
#   owner = Owner.find(id)
#   existing_desc = owner.description
#   halt(404, { message:'Owner not found'}.to_json) unless owner
#   owner.update(first_name: params[:first_name])
#   owner.to_json
# end
#
# delete '/owners/:id' do |id|
#   if ! Owner.exists?(id)
#     status 404
#   else
#     Owner.destroy(id)
#   end
# end
