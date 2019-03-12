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

  def create(*data)

  end

  def show(id)

  end

  def update(id, *data)

  end

  def delete(id, *data)

  end

  def find(id)

  end

  def list

  end

end
