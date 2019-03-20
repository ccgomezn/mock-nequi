require_relative './individual_transaction_controller'
require_relative '../db_managers/mattress_manager'

class MattressController
  def initialize
    @individual_transaction = IndividualTransactionController.new
    @mattress_manager = MattressManager.new
  end

  def debit(amount, location = 'virtual-virtual')
    @individual_transaction.transaction_on_account(
      amount,
      $session[:account_id],
      'mattress',
      $session[:account_id],
      location
    )
  end

  def withdraw(amount, location = 'virtual-virtual')
    @individual_transaction.transaction_on_account(
      - amount,
      $session[:account_id],
      'mattress',
      $session[:account_id],
      location
    )
  end

  def get_balance
    @mattress_manager.find($session[:account_id]).balance
  end

  def insert(balance)
    mattress_map = { balance: balance, account_id: $session[:account_id] }
    @mattress_manager.insert(mattress_map)
  end

  def find(id)
    @mattress_manager.find(id)
  end

  def delete(id)
    @mattress_manager.delete(id)
  end
end
