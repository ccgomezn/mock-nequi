require_relative '../db_managers/user_manager'
require_relative '../models/user'
require_relative './account_controller'
require 'digest'

class UserController
  def initialize
    @account_controller = AccountController.new
    @user_manager = UserManager.new
  end

  def find(id)
    userManager(id)
  end

  def update(id, name, email, password_digest, account_id)
    userManager = UserManager.new
    user_map = { name: name, email: email, password_digest: password_digest, account_id: account_id }
    userManager.update(id, user_map)
  end

  def create(name, email, password)
    account = @account_controller.insert(0, 0)
    user_data = { name: name, email: email,
                  password_digest: Digest::SHA256.hexdigest(password),
                  account_id: account.id }
    if @user_manager.insert(user_data)
      true
    else
      false
    end
  end

  def login(email, password)
    user = @user_manager.login(email, Digest::SHA256.hexdigest(password))
    if user[:state]
      $session[:email] = email
      $session[:account_id] = user[:account_id]
      true
    else
      false
    end
  end

  def delete(id)
    userManager.delete(id)
  end
end
