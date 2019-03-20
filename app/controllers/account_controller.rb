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

  def consign_to_another_account(amount, final_account_email)
    final_account_id = find_by_email(final_account_email)
    if final_account_id.nil? || final_account_id.length.zero?
      return false
    end
    @mutual_transaction.consign_to_another_account(
      amount,
      $session[:account_id],
      'account',
      final_account_id
    )
    true
  end

  def debit(amount, location = "virtual-virtual")
    @individual_transaction.transaction_on_account(
      amount,
      $session[:account_id],
      'account',
      $session[:account_id],
      location
    )
  end

  def withdraw(amount, location = "virtual-virtual")
    @individual_transaction.transaction_on_account(
      - amount,
      $session[:account_id],
      'account',
      $session[:account_id],
      location
    )
  end

  def get_balance()
    data = {}
    data[:available] = @account_manager.find($session[:account_id]).avaiable_balance
    data[:total] = @account_manager.find($session[:account_id]).total_balance
    data
  end

  def find(id)
    @account_manager.find(id)
  end
  
  def find_by_email(email)
    @account_manager.find_id_by_column_join("email", email)
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