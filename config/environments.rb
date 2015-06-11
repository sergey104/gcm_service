require "connection_pool"
require 'activerecord'
require 'mysql2'

# config/environments.rb
# development
configure :development do
  db = URI.parse(ENV['DATABASE_URL'] || 'mysql2:///localhost/gcm')
  pool= 5
  username = root
  password =Remcolor777
  ActiveRecord::Base.establish_connection(
          :adapter  => db.scheme == 'mysql2' ? 'mysql2' : db.scheme,
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
  username = root
  password = Remcolor777
  ActiveRecord::Base.establish_connection(
      :adapter  => db.scheme == 'mysql2' ? 'mysql2' : db.scheme,
      :host     => db.host,
      :username => db.user,
      :password => db.password,
      :database => db.path[1..-1],
      :encoding => 'utf8'
  )
end