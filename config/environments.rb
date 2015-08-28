require "connection_pool"
require 'activerecord'
require 'mysql2'

# config/environments.rb
# development
configure :development do
  db = URI.parse(ENV['DATABASE_URL'] || 'mysql2:///localhost/gcm_development')
  pool= 5
  username = root
  password =Remcolor777
  ActiveRecord::Base.establish_connection(
          :adapter  => 'mysql2',
          :host     => 'localhost',
          :username => 'root',
          :password => 'Remcolor777',
          :database => 'gcm_development',
          :encoding => 'utf8',
          :socket   =>  '/tmp/mysql.sock'
  )
end

# production
configure :production do
  db = URI.parse(ENV['DATABASE_URL'] || 'mysql2:///localhost/gcm')
  pool= 5
  username = root
  password =Remcolor777
  ActiveRecord::Base.establish_connection(
      :adapter  => 'mysql2',
      :host     => 'localhost',
      :username => 'root',
      :password => 'Remcolor777',
      :database => 'gcm',
      :encoding => 'utf8',
      :socket   =>  '/tmp/mysql.sock'
  )
end