require_relative '../user_manager'

class UserController
  include UserManager
  attr_accessor :id, :name, :password_digest, :account_id

  def initialize(params)
    @id = params[:id]
    @name = params[:name]
    @password_digest = params[:password_digest]
    @account_id = params[:account_id]
  end

  def create_user(*data)

  end

  def show_user(id)

  end

  def update_user(id, *data)

  end

  def delete_user(id, *data)

  end

  def find_user(id)

  end

  def list_users

  end

end
