require_relative './individual_transaction_controller'
require_relative '../db_managers/pocket_manager'

class PocketController

  def initialize()
    @individual_transaction = IndividualTransactionController.new()
    @pocket_manager = PocketManager.new()
  end

  def debit(amount, product_id, location)
    @individual_transaction.transaction_on_account(
      amount,
      $session[:account_id],
      'pocket',
      product_id,
      location
    )
  end

  def withdraw(amount, product_id, location)
    @individual_transaction.transaction_on_account(
      - amount,
      $session[:account_id],
      'pocket',
      product_id,
      location
    )
  end


  def insert(name, balance, creation_date)
    pocket_map = {:name => name, :balance => balance, :creation_date => creation_date, :account_id => $session[:account_id]}
    @pocket_manager.insert(pocket_map)
  end

  def find(id)
    @pocket_manager.find(id)
  end

  

  def delete(id)
    @pocket_manager.delete(id)
  end
end
