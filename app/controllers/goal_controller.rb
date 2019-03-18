require_relative './individual_transaction_controller'
class GoalController
  def initialize(db_handler)
    @individual_transaction = IndividualTransactionController.new(db_handler)
  end

  def debit(amount, account_id, product_id, location)
    @individual_transaction.transaction_on_account(
      amount,
      account_id,
      'goal',
      product_id,
      location
    )
  end

  def withdraw(amount, account_id, product_id, location)
    @individual_transaction.transaction_on_account(
      - amount,
      account_id,
      'goal',
      product_id,
      location
    )
  end
end
