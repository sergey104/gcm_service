# -*- coding: utf-8 -*-
source 'https://rubygems.org'
ruby '2.2.0'
require 'erb'
require 'yaml'
database_file = File.join(File.dirname(__FILE__), "config/database.yml")
if File.exist?(database_file)
  database_config = YAML::load(ERB.new(IO.read(database_file)).result)
  adapters = database_config.values.map {|c| c['adapter']}.compact.uniq
  if adapters.any?
    adapters.each do |adapter|
      case adapter
        when 'mysql2'
          gem "mysql2", "~> 0.3.11", :platforms => [:mri, :mingw, :x64_mingw]
          gem "activerecord-jdbcmysql-adapter", :platforms => :jruby
        when 'mysql'
          gem "activerecord-jdbcmysql-adapter", :platforms => :jruby
        when /postgresql/
          gem "pg", "~> 0.17.1", :platforms => [:mri, :mingw, :x64_mingw]
          gem "activerecord-jdbcpostgresql-adapter", :platforms => :jruby
        when /sqlite3/
          gem "sqlite3", :platforms => [:mri, :mingw, :x64_mingw]
          gem "jdbc-sqlite3", "< 3.8", :platforms => :jruby
          gem "activerecord-jdbcsqlite3-adapter", :platforms => :jruby
        when /sqlserver/
          gem "tiny_tds", "~> 0.6.2", :platforms => [:mri, :mingw, :x64_mingw]
          gem "activerecord-sqlserver-adapter", :platforms => [:mri, :mingw, :x64_mingw]
        else
          warn("Unknown database adapter `#{adapter}` found in config/database.yml, use Gemfile.local to load your own database gems")
      end
    end
  else
    warn("No adapter found in config/database.yml, please configure it first")
  end
else
  warn("Please configure your config/database.yml first")
end
gem 'sinatra'
gem 'rake'
gem 'redis'
gem 'redis-namespace'
gem 'redis-objects'
gem 'mysql2'
gem 'gcm'
gem 'minitest'
gem 'json'
gem 'activerecord'
gem 'sinatra-activerecord'