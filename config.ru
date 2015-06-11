#\ -w -p 4000 #
require './app/routes.rb'
require 'pg'

run Sinatra::Application # run application
set :database, ENV['DATABASE_URL'] || 'postgres://postgres:postgres@localhost/mydb'
set :environment, :development