require_relative '../db_managers/transaction_manager'
require_relative '../db_managers/mutual_transaction_manager'
require_relative '../db_managers/account_manager'
require_relative '../models/mutual_transaction'




class MutualTransactionController

  def initialize()
    @transaction_manager = TransactionManager.new()
    @mutual_transaction_manager = MutualTransactionManager.new()
    @account_manager = AccountManager.new()
  end

  def consign_to_another_account(amount, origin_account_id, final_account_id)
    transaction = create_transaction(amount)
    create_mutual_transaction(origin_account_id, final_account_id, transaction.id)
    update_balance(amount, origin_account_id, final_account_id)
  end

  private

  def create_transaction(amount)
    date = DateTime.now
    data_transaction = { date: date.strftime('%Y-%m-%d %H:%M:%S'),
                         amount: amount }
    @transaction_manager.insert data_transaction
  end

  def create_mutual_transaction(origin_account_id, final_account_id, transaction_id)
    data_mutual_transaction = { transaction_id: transaction_id,
                                origin_account_id: origin_account_id,
                                final_account_id: final_account_id }
    @mutual_transaction_manager.insert(data_mutual_transaction)
  end

  def update_balance(amount, origin_account_id, final_account_id)
    origin_account = @account_manager.find(origin_account_id)
    final_account = @account_manager.find(final_account_id)
    data_origin_account = { available_balance: origin_account.avaiable_balance -
                                               amount,
                            total_balance: origin_account.total_balance -
                                           amount }
    data_final_account = { available_balance: final_account.avaiable_balance +
                                              amount,
                           total_balance: final_account.total_balance + amount }
    @account_manager.update(origin_account_id, data_origin_account)
    @account_manager.update(final_account_id, data_final_account)
  end

    def insert(transaction_id, origin_account_id, final_account_id)
      mutualTransactionManager = MutualTransactionManager.new()
      mutual_map = { transaction_id: transaction_id, origin_account_id: origin_account_id, final_account_id: final_account_id }
      mutualTransactionManager.insert(mutual_map)
    end

    def find(id)
      mutualTransactionManager.find(id)
    end

    def update(id, transaction_id, origin_account_id, final_account_id)
      mutualTransactionManager = MutualTransactionManager.new()
      mutual_map = { transaction_id: transaction_id, origin_account_id: origin_account_id, final_account_id: final_account_id }
      mutualTransactionManager.update(id, mutual_map)
    end

    def delete(id)
      mutualTransactionManager.delete(id)
    end

end
