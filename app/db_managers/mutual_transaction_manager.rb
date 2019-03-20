require_relative 'helpers/validate_data'
require_relative '../models/mutual_transaction'
require_relative 'helpers/sql_query_executor'

class MutualTransactionManager
  include ValidateData
  include SqlQueryExecutor

  def insert(params)
    if valid_data?(params)

      if insert_execution('mutual_transactions', params)
        mutual_transaction_id = get_last_register_execution('mutual_transactions')
        params[:id] = mutual_transaction_id
        MutualTransaction.new(params)
      else
        false
      end
    else
      false
    end
  end

  def find(id)
    find_execution('mutual_transactions', id)
    MutualTransaction.new
  end

  # UPDATE And DELETE builders need a dict with the columns and values, if empty value = nil
  def update(id, params)
    if valid_data?(params)
      update_execution('mutual_transactions', params, id)
    else
      print("ERROR: couldn't insert account data")
    end
  end

  def delete(id)
    delete_execution('mutual_transactions', id)
  end

  private

  def valid_data?(params)
    transaction_id_valid = params.key?(:transaction_id) ?
                           numeric_validation(params[:transaction_id]) : true
    origin_account_id_valid = params.key?(:origin_account) ?
                              numeric_validation(params[:origin_account]) : true
    final_account_id_valid = params.key?(:final_account) ?
                             numeric_validation(params[:final_account]) : true

    if transaction_id_valid && origin_account_id_valid && \
       final_account_id_valid
      return true
    else
      return false
    end
  end
end
