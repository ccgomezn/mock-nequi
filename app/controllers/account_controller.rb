require_relative './individual_transaction_controller'
require_relative './mutual_transaction_controller'
require_relative '../db_managers/account_manager'

class AccountController

  def initialize(db_handler)
    @individual_transaction = IndividualTransactionController.new(db_handler)
    @mutual_transaction = MutualTransactionController.new(db_handler)
    @account_manager = AccountManager.new(db_handler)
  end

  def consign_to_another_account(amount, origin_account_id, final_account_id)
    @mutual_transaction.consign_to_another_account(
      amount,
      origin_account_id,
      final_account_id
    )
  end

  def debit(amount, account_id, location)
    @individual_transaction.transaction_on_account(
      amount,
      account_id,
      'account',
      account_id,
      location
    )
  end

  def withdraw(amount, account_id, location)
    @individual_transaction.transaction_on_account(
      - amount,
      account_id,
      'account',
      account_id,
      location
    )
  end
  
  def find(id)
    @account_manager.find(id)
  end
  
  def insert(avaiable_balance, total_balance, creation_date)
    account_map = {:avaiable_balance => avaiable_balance, :total_balance => total_balance, :creation_date => creation_date}
    @account_manager.insert(account_map)
  end
    
  def delete(id)
    @account_manager.delete(id)
  end
end