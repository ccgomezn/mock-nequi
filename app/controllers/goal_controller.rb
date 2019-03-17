require_relative '../db_managers/goal_manager'
require_relative '../../db/db_handler'
require_relative '../models/Goal'

class GoalController
  include GoalManager

  def initialize(db_handler)
    @db_handler = db_handler
  end

  def insert(name, goal, balance, state, deadline, creation_date, account_id)
    goalManager = GoalManager.new(@db_handler)
    goal_map = {:name => name, :goal => goal, :state => state, :deadline => deadline, :creation_date => creation_date, :account_id}
    goalManager.insert(goal_map)
  end

  def find(id)
    goalManager.find(id)
  end

  def update(id, name, goal, balance, state, deadline, creation_date, account_id)
    goalManager = GoalManager.new(@db_handler)
    goal_map = {:name => name, :goal => goal, :state => state, :deadline => deadline, :creation_date => creation_date, :account_id}
    goalManager.update(id, goal_map)
  end

  def delete(id)
    goalManager.delete(id)
  end
end
