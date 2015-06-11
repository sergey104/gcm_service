require "connection_pool"
require 'activerecord'
require 'pg'

Redis::Objects.redis = ConnectionPool.new(size: 5, timeout: 5) { Redis.new(:host => "127.0.0.1", :port => 6379) }

# config/environments.rb
# development
configure :development do
  db = URI.parse(ENV['DATABASE_URL'] || 'postgres:///localhost/mydb')
  pool= 5
  username = fil
  password =postgres
  ActiveRecord::Base.establish_connection(
          :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
          :host     => db.host,
          :username => db.user,
          :password => db.password,
          :database => db.path[1..-1],
          :encoding => 'utf8'
  )
end

# production
configure :production do
  db = URI.parse(ENV['DATABASE_URL'] || 'postgres:///localhost/mydb')
  pool= 5
  username = fil
  password =postgres
  ActiveRecord::Base.establish_connection(
          :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
          :host     => db.host,
          :username => db.user,
          :password => db.password,
          :database => db.path[1..-1],
          :encoding => 'utf8'
  )
end