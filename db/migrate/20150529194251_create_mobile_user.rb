# db/migrate/xxx_create_mobile_users.rb
# -*- coding: utf-8 -*-
  class CreateMobileUser < ActiveRecord::Migration
    def self.up
      #
      create_table :mobile_users do |mobile_user|
        mobile_user.string     :user_id
        mobile_user.string     :reg_id
        mobile_user.timestamps
      end
      #
      MobileUser.create(user_id: "12345678",
                  reg_id: "AAR34tyAHN6479_weDATLOIJ7863")
    end
    def self.down
      #
      drop_table :mobile_users
    end
  end