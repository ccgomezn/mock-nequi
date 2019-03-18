class Mattress
  attr_accessor :id, :balance, :account_id

  def initialize(params)
    @id = params[:id]
    @balance = params[:balance]
    @account_id = params[:account_id]
  end
end
