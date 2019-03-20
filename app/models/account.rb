class Account
  attr_accessor :id, :avaiable_balance, :total_balance, :creation_date

  def initialize(params)
    @id = params[:id]
    @avaiable_balance = params[:avaiable_balance]
    @total_balance = params[:total_balance]
    @creation_date = params[:creation_date]
  end
end
