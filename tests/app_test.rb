ENV['RACK_ENV'] = 'test'
require '../app/routes'
require "minitest/autorun"
require '../app/models'


class MyRedisTests < Minitest::Test
  def setup
    @redis_new = MyRedis.new
    @reg = Array.new(10) {rand(10000)}
    @user = Array.new(10) {rand(500)}
  end

  def test_reg_ids_addition
  assert(@redis_new.add_reg_id("1234","54637488839393AA"),"wrong test")
  n = 0
    while n < 10 do
      assert(@redis_new.add_reg_id(@reg[n].to_s,@user[n].to_s),"wrong test")
      n = n+1
    end
  end

  def test_reg_ids_deletion
    assert(@redis_new.delete_reg_id("54637488839393AA"),"wrong test")
    n = 0
    while n < 10 do
      assert(@redis_new.delete_reg_id(@reg[n].to_s),"wrong test")
      n = n+1
    end
  end
end



