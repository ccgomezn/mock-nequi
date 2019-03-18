require_relative './individual_transaction_controller'
require_relative '../db_managers/goal_manager'

class GoalController
  def initialize(db_handler)
    @individual_transaction = IndividualTransactionController.new(db_handler)
    @goal_manager = GoalManager.new(db_handler)
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

  def insert(name, goal, balance, state, deadline, creation_date, account_id)
    goal_map = {:name => name, :goal => goal, :state => state, :deadline => deadline, :creation_date => creation_date, :account_id}
    @goal_manager.insert(goal_map)
  end

  def find(id)
    @goal_manager.find(id)
  end

  def delete(id)
    @goal_manager.delete(id)
  end
end
