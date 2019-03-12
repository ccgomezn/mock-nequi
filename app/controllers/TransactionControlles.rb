require_relative '../transaction_manager'

class TransactionController
  include TransactionManager
  attr_accessor :id, :date, :amount

  def initialize(params)
    @id = params[:id]
    @date = params[:date]
    @amount = params[:amount]
  end

  def create_transaction(*data)

  end

  def show_transaction(id)

  end

  def update_transaction(id, *data)

  end

  def delete_transaction(id, *data)

  end

  def find_transaction(id)

  end

  def list_transactions

  end

end
