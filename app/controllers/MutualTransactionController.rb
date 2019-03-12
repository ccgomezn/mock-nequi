require_relative '../individual_transaction_manager'

class IndividualTransactionController
  include IndividualTransactionManager
  attr_accessor :id, :product, :location, :transaction_id, :account_id

  def initialize(params)
    @id = params[:id]
    @product = params[:product]
    @location = params[:location]
    @transaction_id = params[:transaction_id]
    @account_id = params[:account_id]
  end

  def create(*data)

  end

  def show(id)

  end

  def update(id, *data)

  end

  def delete(id, *data)

  end

  def find(id)

  end

  def list

  end

end
