require_relative '../db_managers/transaction_manager'
require_relative '../models/transaction'

class TransactionController
  
  def initialize
    @transaction_manager =TransactionManager.new()
  end

  def get_all_transactions()
    transactions = @transaction_manager.get_all_transactions($session[:account_id])
    transactions
  end

end
