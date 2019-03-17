class Transaction
  attr_accessor :date, :amount, :id

  def initialize(params)
    @id = params[:id]
    @date = params[:date]
    @amount = params[:amount]
  end
end
