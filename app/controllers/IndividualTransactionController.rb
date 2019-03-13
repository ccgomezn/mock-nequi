require_relative '../mutual_transaction_manager'

class MutualTransactionController

  include MutualTransactionManager

  attr_accessor :transaction_id, :origin_account_id, :final_account_id



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
