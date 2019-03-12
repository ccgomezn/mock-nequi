require_relative '../transaction_manager'

class TransactionController

  include TransactionManager

  attr_accessor :id, :date, :amount

  def initialize(params)
    @id = params[:id]
    @date = params[:date]
    @amount = params[:amount]
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
