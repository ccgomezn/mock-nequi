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

  def create(*data)

  end

  def show(id)

  end

  def update(id, *data)

  end

  def delete(id, *data)

  end

  def find(id)

  end

  def list

  end

end
