require_relative '../db_managers/transaction_manager'
require_relative '../db_managers/mutual_transaction_manager'
require_relative '../db_managers/account_manager'
require_relative '../../db/db_handler'

class MutualTransactionController
  
  def initialize(db_handler)
    @db_handler = db_handler
  end

  def consign_to_another_account(amount, origin_account_id, final_account_id)
    transaction = create_transaction(amount)
    create_mutual_transaction(origin_account_id, final_account_id, transaction.id)
    update_balance(amount, origin_account_id, final_account_id)
  end

  private

  def create_transaction(amount)
    transaction_manager = TransactionManager.new(@db_handler)
    date = DateTime.now
    data_transaction = { date: date.strftime('%Y-%m-%d %H:%M:%S'), 
                         amount: amount }
    transaction_manager.insert data_transaction
  end

  def create_mutual_transaction(origin_account_id, final_account_id, transaction_id)
    mutual_transaction_manager = MutualTransactionManager.new(@db_handler)
    data_mutual_transaction = { transaction_id: transaction_id,
                                origin_account_id: origin_account_id,
                                final_account_id: final_account_id }
    mutual_transaction_manager.insert(data_mutual_transaction)
  end

  def update_balance(amount, origin_account_id, final_account_id)
    account_manager = AccountManager.new(@db_handler)
    origin_account = account_manager.find(origin_account_id)
    final_account = account_manager.find(final_account_id)
    data_origin_account = { available_balance: origin_account.avaiable_balance -
                                               amount,
                            total_balance: origin_account.total_balance -
                                           amount }
    data_final_account = { available_balance: final_account.avaiable_balance +
                                              amount,
                           total_balance: final_account.total_balance + amount }
    account_manager.update(origin_account_id, data_origin_account)
    account_manager.update(final_account_id, data_final_account)
  end
end
