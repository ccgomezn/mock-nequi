require_relative '../db_managers/user_manager'
require_relative '../models/user'

class UserController

  def insert(name, email, password_digest, account_id)
    userManager = UserManager.new()
    user_map = {:name => name, :email => email, :password_digest => password_digest, :account_id => account_id}
    userManager.insert(user_map)
  end

  def find(id)
    userManager(id)
  end

  def update(id, name, email, password_digest, account_id)
    userManager = UserManager.new()
    user_map = {:name => name, :email => email, :password_digest => password_digest, :account_id => account_id}
    userManager.update(id, user_map)
  end

  def delete(id)
    userManager.delete(id)
  end
end
