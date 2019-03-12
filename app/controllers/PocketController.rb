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

  def lists

  end

end
