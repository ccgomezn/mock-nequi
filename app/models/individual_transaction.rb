class IndividualTransaction
  attr_accessor  :product, :location, :transaction_id, :account_id

  def initialize(params)
    @product = params[:product]
    @location = params[:location]
    @transaction_id = params[:transaction_id]
    @account_id = params[:account_id]
  end
end
