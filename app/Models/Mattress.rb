class Mattress
  attr_accessor :id, :balance, :account_id

  def initialize(params)
    @balance = params[:balance]
    @account_id = params[:account_id]
  end
end
