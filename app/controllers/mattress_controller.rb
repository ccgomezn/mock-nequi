require_relative './individual_transaction_controller'
require_relative '../db_managers/mattress_manager'

class MattressController

  def initialize(db_handler)
    @individual_transaction = IndividualTransactionController.new(db_handler)
    @mattress_manager = MattressManager.new(@db_managers)
  end

  def debit(amount, account_id, product_id, location)
    @individual_transaction.transaction_on_account(
      amount,
      account_id,
      'mattress',
      product_id,
      location
    )
  end

  def withdraw(amount, account_id, product_id, location)
    @individual_transaction.transaction_on_account(
      - amount,
      account_id,
      'mattress',
      product_id,
      location
    )
  end

  def insert(balance, account_id)
    mattress_map = {:balance => balance, :account_id => account_id}
    @mattress_manager.insert(mattress_map)
  end

  def find(id)
    @mattress_manager.find(id)
  end

  def delete(id)
    @mattress_manager.delete(id)
  end
end
