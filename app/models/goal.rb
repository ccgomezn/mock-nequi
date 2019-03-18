class Goal
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
end
