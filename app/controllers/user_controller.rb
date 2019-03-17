require_relative '../db_managers/user_manager'
require_relative '../../db/db_handler'
require_relative '../models/User'

class UserController
  include UserManager

  def initialize(db_handler)
    @db_handler = db_handler
  end

  userManager = UserManager.new(db_handler)

  def insert(name, email, password_digest, account_id)
    user_map = {:name => name, :email => email, :password_digest => password_digest, :account_id => account_id}
    userManager.insert(user_map)
  end

  def find(id)
    userManager(id)
  end

  def update(id, name, email, password_digest, account_id)
    user_map = {:name => name, :email => email, :password_digest => password_digest, :account_id => account_id}
    userManager.update(id, user_map)
  end

  def delete(id)
    userManager.delete(id)
  end
end
