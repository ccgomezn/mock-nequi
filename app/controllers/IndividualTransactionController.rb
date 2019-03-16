
class IndividualTransactionController

  def initialize(db_handler)
    @db_handler = db_handler
  end

  def consign_to_account(amount, final_account, product, product_id, location)
    transaction = create_transaction(amount)
    create_individual_transaction(product, product_id, location, transaction.id,
                                  final_account)
  end

  private

  def create_transaction(amount)
    transaction_manager = TransactionManager.new(@db_handler)
    date = DateTime.now
    date.strftime('%d/%m/%Y %H:%M:%S')
    data_transaction = { date: date, amout: amount }
    transaction_manager.insert data_transaction
  end

  def create_individual_transaction(product, product_id, location,
                                    transaction_id, account_id)

    individual_transaction_manager = IndividualTransactionManager.new(@db_handler)
    data_individual_transaction = { transaction_id: transaction_id,
                                    product: product,
                                    product_id: product_id,
                                    location: location,
                                    account_id: account_id }
    individual_transaction_manager.insert(data_individual_transaction)
  end
end
