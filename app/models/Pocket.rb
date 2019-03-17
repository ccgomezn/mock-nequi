class Pocket
  attr_accessor :id, :name, :balance, :creation_date, :account_id

  def initialize(params)
    @id = params[:id]
    @name = params[:name]
    @balance = params[:balance]
    @creation_date = params[:creation_date]
    @account_id = params[:account_id]
  end
end
