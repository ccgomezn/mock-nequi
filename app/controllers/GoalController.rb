require_relative '../goal_manager'

class GoalController
  include GoalManager
  attr_accessor :id, :name, :goal, :balance, :state, :deadline, :creation_date, :account_id

  def initialize(params)
    @id = params[:id]
    @name = params[:name]
    @goal = params[:goal]
    @balance = params[:balance]
    @state = params[:state]
    @deadline = params[:deadline]
    @creation_date = params[:creation_date]
    @account_id = params[:account_id]
  end

  def create_goal(*data)

  end

  def show_goal(id)

  end

  def update_goal(id, *data)

  end

  def delete_goal(id, *data)

  end

  def find_goal(id)

  end

  def list_goals

  end

end
