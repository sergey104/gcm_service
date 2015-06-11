# -*- coding: utf-8 -*-
# app/routes.rb
require "sinatra"
require "redis"
require "redis-namespace"
require "redis-objects"
$LOAD_PATH.unshift(File.dirname(__FILE__))
require "models"  # models
require "helpers" # helpers
require "constants"

$working = false
configure do
  # logging is enabled by default in classic style applications,
  # so `enable :logging` is not needed
  file = File.new("#{settings.root}/log/#{settings.environment}.log", 'a+')
  file.sync = true
  use Rack::CommonLogger, file
end

# post request to add registration id
post "/add" do
  user_id = params[:user_id]
  reg_id = params[:reg_id]
  my = MyRedis.new
  my.add_reg_id(user_id, reg_id)
end
# post request to add message to queue
post "/message" do
  body = params[:body]
  url = params[:url]
  Thread.new {
    my = MyRedis.new
    message_whole = "{\"body\":"  + "\"#{body}\"," + "\"url\":" +  "\"#{url}\"" + "}"
    my.push_message_to_stack(message_whole)
    my.send_message_to_all_users
  }
end
