require_relative '../pocket_manager'

class PocketController
  include PocketManager
  attr_accessor :id, :name, :balance, :creation_date, :account_id

  def initialize(params)
    @id = params[:id]
    @name = params[:name]
    @balance = params[:balance]
    @creation_date = params[:creation_date]
    @account_id = params[:account_id]
  end

  def create_pocket(*data)

  end

  def show_pocket(id)

  end

  def update_pocket(id, *data)

  end

  def delete_pocket(id, *data)

  end

  def find_pocket(id)

  end

  def list_pockets

  end

end
