class MutualTransaction
  attr_accessor :transaction_id, :origin_account_id, :final_account_id
  def initialize(params)
    @transaction_id = params[:transaction_id]
    @origin_account_id = params[:origin_account_id]
    @final_account_id = params[:final_account_id]
  end
end