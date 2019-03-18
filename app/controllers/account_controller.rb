require_relative './individual_transaction_controller'
require_relative './mutual_transaction_controller'
require_relative '../db_managers/account_manager'
require_relative '../db_managers/mattress_manager'

class AccountController

  def initialize()
    @individual_transaction = IndividualTransactionController.new()
    @mutual_transaction = MutualTransactionController.new()
    @account_manager = AccountManager.new()
    @mattress_manager = MattressManager.new()
  end

  def consign_to_another_account(amount, final_account_id)
    @mutual_transaction.consign_to_another_account(
      amount,
      $session[:account_id],
      final_account_id
    )
  end

  def debit(amount, location)
    @individual_transaction.transaction_on_account(
      amount,
      $session[:account_id],
      'account',
      $session[:account_id],
      location
    )
  end

  def withdraw(amount, location)
    @individual_transaction.transaction_on_account(
      - amount,
      $session[:account_id],
      'account',
      $session[:account_id],
      location
    )
  end
  
  def find(id)
    @account_manager.find(id)
  end
  
  def insert(avaiable_balance, total_balance)
    date = DateTime.now
    account_map = {:available_balance => avaiable_balance, :total_balance => total_balance, :creation_date => date.strftime('%Y-%m-%d %H:%M:%S')}
    account = @account_manager.insert(account_map)
    @mattress_manager.insert({balance: 0, account_id: account.id})
  end
    
  def delete(id)
    @account_manager.delete(id)
  end
end