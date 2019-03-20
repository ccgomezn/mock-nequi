require_relative 'helpers/validate_data'
require_relative '../models/individual_transaction'
require_relative 'helpers/sql_query_executor'

class IndividualTransactionManager
  include ValidateData
  include SqlQueryExecutor

  def insert(params)
    if valid_data?(params)

      if insert_execution('individual_transactions', params)
        individual_transaction = get_last_register_execution('individual_transactions')
        params[:id] = individual_transaction[0]
        IndividualTransaction.new(params)
      else
        false
      end
    else
      false
    end
  end

  def find(id)
    find_execution('individual_transactions', id)
    IndividualTransaction.new
  end

  # UPDATE And DELETE builders need a dict with the columns and values, if empty value = nil
  def update(id, params)
    if valid_data?(params)
      update_execution('individual_transactions', params, id)
    else
      print("ERROR: couldn't insert account data")
    end
  end

  def delete(id)
    delete_execution('individual_transactions', id)
  end

  private

  def valid_data?(params)
    product_id_valid = params.key?(:product_id) ?
                    numeric_validation(params[:product_id]) : true
    location_valid = params.key?(:location) ?
                     location_validation(params[:location]) : true
    transaction_id_valid = params.key?(:transaction_id) ?
                           numeric_validation(params[:transaction_id]) : true
    account_id_valid = params.key?(:account_id) ?
                      numeric_validation(params[:account_id]) : true

    if product_id_valid && location_valid && \
       transaction_id_valid && account_id_valid
      return true
    else
      return false
    end
 end
end
