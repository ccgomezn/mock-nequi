require_relative '../transaction_manager'

class TransactionController

  include TransactionManager

  attr_accessor :date, :amount

  def initialize(db_handler)
    @db_handler = db_handler
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
