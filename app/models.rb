# app/models.rb
require 'sinatra'
require 'sinatra/activerecord'
require 'constants'
require 'redis'
require 'redis-namespace'
require 'redis-objects'
require 'json'
require 'gcm'
require 'thread'


class AndroidUser
  def user_id
    @user_id
  end

  def registration_id
    @registration_id
  end
end

class Message
  def id
    @id
  end

  def message
    @message
  end
end

class MyRedis < Redis
  @redis

  def initialize
    @lock = Mutex.new
    @redis = Redis.new(host: HOST, port: PORT, db:0)
  end

  def send_message_to_all_users
    ids = get_all_reg_ids
    mark("ids = " + ids.to_s)
    while get_message_stack_size > 0
      mess = pop_message_from_stack
      mark(mess)
      parsed = JSON.parse(mess)

      ids.each do |reg_id|
        gcm = GCM.new(API_ID)
        options = { data: {message: parsed["body"], url: parsed["url"]}, registration_ids: [reg_id] }
        response = gcm.send(reg_id, options)
        if analyze(response) == 2
          delete_reg_id(reg_id)
        end
        if analyze(response) == 3
          delete_reg_id(reg_id)
        end
        if analyze(response) == 4
          put_in_delay(options)
        end
      end
    end
  end

  def send_message_to_user(reg_id, message)
    if (check_reg_id(reg_id) != 0)
      gcm = GCM.new(API_ID)
      options = {data: {message: message}, registration_ids: [reg_id]}
      response = gcm.send(registration_ids, options)
      analyze(response)
    end
  end

  def add_message(message, id)
    @lock.synchronize {
      @redis.set(message, id)
    }
    @redis.quit
  end

  def add_reg_id(user_id, reg_id)
    @lock.synchronize {
      @redis.hmset("device:" + reg_id, "user_id", user_id)
      @redis.hmset("device:" + reg_id, "reg_id", reg_id)
      @redis.hset("devices", reg_id, user_id)
    }
    @redis.quit
  end

  def check_reg_id(reg_id)
    @redis.exists("device:" + reg_id)
  end

  def delete_reg_id(reg_id)
    @lock.synchronize {
      if @redis.exists("device:" + reg_id) == true
        @redis.del("device:" + reg_id)
        @redis.hdel("devices", reg_id)
      end
    }
    @redis.quit
  end

  def get_all_reg_ids
    @lock.synchronize {
      list = @redis.hkeys("devices")
      @redis.quit
      list
    }
  end

  def push_message_to_stack(message)
    @lock.synchronize {
      @redis.rpush("messages", message)
      @redis.quit
    }
  end

  def pop_message_from_stack
    @lock.synchronize {
      res = @redis.lpop("messages")
      @redis.quit
      res
    }
  end

  def get_message_stack_size
    @lock.synchronize {
      res = @redis.llen("messages")
      @redis.quit
      res
    }
  end

  def put_message_to_arc(message)
    @lock.synchronize {
      res = @redis.incr("next_message_id")
      @redis.hset("messages_arc", res, message)
      @redis.quit
    }
  end

  def put_in_delay(options)
    @lock.synchronize {
      @redis.rpush("delays", options)
      @redis.quit
    }
  end
end

def mark(message)
  target = open("mess.txt", "a")
  target.write(message)
  target.write("\n")
  target.close
end

def analyze(response)
  answer = JSON.parse(response[:body])
  return 1 if answer["success"] == 1
  ret = answer["results"].to_s
  return 2 if ret.include? 'InvalidRegistration'
  return 3 if ret.include? 'NotRegistered'
  return 4 if ret.include? 'Unavailable'
  return 0

end