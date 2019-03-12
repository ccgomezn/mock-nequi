require_relative '../mattresses_manager'

class MatressController
  include MattressesManager
  attr_accessor :id, :balance, :account_id

  def initialize(params)
    @id = params[:id]
    @balance = params[:balance]
    @account_id = params[:account_id]
  end

  def create_matress(*data)

  end

  def show_matress(id)

  end

  def update_matress(id, *data)

  end

  def delete_matress(id, *data)

  end

  def find_matress(id)

  end

  def list_matresses

  end

end
