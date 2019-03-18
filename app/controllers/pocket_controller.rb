require_relative './individual_transaction_controller'
require_relative '../db_managers/pocket_manager'

class PocketController

  def initialize(db_handler)
    @individual_transaction = IndividualTransactionController.new(db_handler)
    @pocket_manager = PocketManager.new(@db_handler)
  end

  def debit(amount, account_id, product_id, location)
    @individual_transaction.transaction_on_account(
      amount,
      account_id,
      'pocket',
      product_id,
      location
    )
  end

  def withdraw(amount, account_id, product_id, location)
    @individual_transaction.transaction_on_account(
      - amount,
      account_id,
      'pocket',
      product_id,
      location
    )
  end


  def insert(name, balance, creation_date, account_id)
    pocket_map = {:name => name, :balance => balance, :creation_date => creation_date, :account_id => account_id}
    @pocket_manager.insert(pocket_map)
  end

  def find(id)
    @pocket_manager.find(id)
  end

  

  def delete(id)
    @pocket_manager.delete(id)
  end
end
