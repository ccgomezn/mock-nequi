require_relative '../mutual_transaction_manager'

class MutualTransactionController
  include MutualTransactionManager
  attr_accessor :id, :transaction_id, :origin_account_id, :final_account_id

  def initialize(params)
    @id = params[:id]
    @transaction_id = params[:transaction_id]
    @origin_account_id = params[:origin_account_id]
    @final_account_id = params[:final_account_id]
  end

  def create_mutual_transaction(*data)

  end

  def show_mutual_transaction(id)

  end

  def update_mutual_transaction(id, *data)

  end

  def delete_mutual_transaction(id, *data)

  end

  def find_mutual_transaction(id)

  end

  def list_mutual_transactions

  end

end
