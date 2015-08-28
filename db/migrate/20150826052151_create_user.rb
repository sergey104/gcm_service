class CreateUser < ActiveRecord::Migration
  def self.up
    # создание таблицы с заданными полями
    create_table :users do |user|
      user.string   :name
      user.string   :akey
    end
    # тестовые записи
    #users.create(name: "Fil",
                #akey: "11223344556677")
    #users.create(name: "SecondName",
                #akey: "12323454567771")
  end
  def self.down
    # откатить миграцию (rake:db rollback)
    drop_table :users
  end
end