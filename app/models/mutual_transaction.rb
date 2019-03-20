class MutualTransaction
  attr_accessor :transaction_id, :origin_account_id, :final_account_id, :origin_product_type
  def initialize(params)
    @transaction_id = params[:transaction_id]
    @origin_id = params[:origin_id]
    @origin_product_type = params[:origin_product_type]
    @final_account_id = params[:final_account_id]
  end
end