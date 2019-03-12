class Transaction
  attr_accessor  :date, :amount

  def initialize(params)
    @date = params[:date]
    @amount = params[:amount]
  end
end
