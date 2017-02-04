require_relative 'api_owner'
require_relative 'api_pet'
set :public_folder, 'public'

run Sinatra::Application
