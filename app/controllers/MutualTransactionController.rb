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

  def create_individual_transaction(*data)

  end

  def show_individual_transaction(id)

  end

  def update_individual_transaction(id, *data)

  end

  def delete_individual_transaction(id, *data)

  end

  def find_individual_transaction(id)

  end

  def list_individual_transactions

  end

end
