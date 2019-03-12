class Pocket
  attr_accessor  :name, :balance, :creation_date, :account_id

  def initialize(params)
    @name = params[:name]
    @balance = params[:balance]
    @creation_date = params[:creation_date]
    @account_id = params[:account_id]
  end
end
