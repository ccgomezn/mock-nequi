require_relative './individual_transaction_controller'
require_relative '../db_managers/goal_manager'

class GoalController
  def initialize()
    @individual_transaction = IndividualTransactionController.new()
    @goal_manager = GoalManager.new()
  end

  def debit(amount, product_id, location = "virtual-virtual")
    @individual_transaction.transaction_on_account(
      amount,
      $session[:account_id],
      'goal',
      product_id,
      location
    )
  end

  def withdraw(amount, product_id, location = "virtual-virtual")
    @individual_transaction.transaction_on_account(
      - amount,
      $session[:account_id],
      'goal',
      product_id,
      location
    )
  end

  def get_balance(product_id)
    @goal_manager.find(product_id).balance
  end

  def find_all
    @goal_manager.find_all($session[:account_id])
  end
  

  def insert(name, goal, deadline)
    date = DateTime.now
    goal_map = {:balance => 0,:name => name, :goal => goal.to_i, :state => 'No cumplida', :deadline => deadline, :creation_date => date.strftime('%Y-%m-%d %H:%M:%S'), :account_id => $session[:account_id]}
    @goal_manager.insert(goal_map)
  end

  def find(id)
    @goal_manager.find(id)
  end

  def delete(id)
    @goal_manager.delete(id)
  end
end
