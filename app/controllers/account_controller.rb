require_relative './individual_transaction_controller'
require_relative './mutual_transaction_controller'

class AccountController

  def initialize(db_handler)
    @individual_transaction = IndividualTransactionController.new(db_handler)
    @mutual_transaction = MutualTransactionController.new(db_handler)
  end

  def consign_to_another_account(amount, origin_account_id, final_account_id)
    @mutual_transaction.consign_to_another_account(
      amount,
      origin_account_id,
      final_account_id
    )
  end

  def debit(amount, account_id, product_id, location)
    @individual_transaction.transaction_on_account(
      amount,
      account_id,
      'account',
      product_id,
      location
    )
  end

  def withdraw(amount, account_id, product_id, location)
    @individual_transaction.transaction_on_account(
      - amount,
      account_id,
      'account',
      product_id,
      location
    )
  end

end
