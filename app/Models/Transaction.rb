class Transaction
  attr_accessor :id, :date, :amount

  def initialize(params)
    @date = params[:date]
    @amount = params[:amount]
  end
end
