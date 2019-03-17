require_relative '../db_managers/transaction_manager'
require_relative '../../db/db_handler'
require_relative '../models/Transaction'

class TransactionController
  include TransactionManager

  def initialize(db_handler)
    @db_handler = db_handler
  end

  def insert(date, amount)
    transactionManager = TransactionManager.new(@db_handler)
    transaction_map = {:date => date, :amount => amount}
    transactionManager.insert(transaction_map)
  end

  def find(id)
    transactionManager.find(id)
  end

  def update(id, date, amount)
    transactionManager = TransactionManager.new(@db_handler)
    transaction_map = {:date => date, :amount => amount}
    transactionManager.update(id, transaction_map)
  end

  def delete(id)
    transactionManager.delete(id)
  end
end
