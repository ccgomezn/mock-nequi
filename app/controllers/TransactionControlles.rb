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

  def consign_to_another_account(amount, origin_account, final_account )
    create_transaction(amount)

  end


  private

  def create_transaction(amount)
    transaction_manager = TransactionManager.new(@db_handler)
    date = DateTime.now
    date.strftime('%d/%m/%Y %H:%M')
    data_transaction = { date: date, amout: amount }
    transaction_manager.insert data_transaction
  end

  def create_mutual_transaction(origin_account, final_account, id_transaction)
    mutual_transaction_manager = MutualTransactionManager.new(@db_handler))
    
  end
end
