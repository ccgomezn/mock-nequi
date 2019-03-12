require_relative '../mattresses_manager'

class MatressController

  include MattressesManager
  
  attr_accessor :id, :balance, :account_id

  def initialize(params)
    @id = params[:id]
    @balance = params[:balance]
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
