require_relative 'helpers/validate_data'
require_relative '../models/account'
require_relative 'helpers/sql_query_executor'

class AccountManager
  include ValidateData
  include SqlQueryExecutor

  def insert(params)
    if valid_data?(params)

      if insert_execution('accounts', params)
        account_id = get_last_register_execution('accounts')
        params[:id] = account_id[0]

        Account.new(params)
      else
        false
      end
    else
      false
    end
  end

  def find(id)
    data_query = find_execution('accounts', id)
    return nil if data_query.nil?

    data_account = { id: data_query[0], avaiable_balance: data_query[1],
                     total_balance: data_query[2], creation_date: data_query[3] }
    Account.new(data_account)
  end

  def find_id_by_column_join(column, data)
    find_id_column_join_execution('user', 'account', column, data)
  end

  # UPDATE And DELETE builders need a dict with the columns and values, if empty value = nil
  def update(id, params)
    if valid_data?(params)
      update_execution('accounts', params, id)
    else
      print("ERROR: couldn't insert account data")
    end
  end

  def delete(id)
    delete_execution('accounts', id)
  end

  private

  def valid_data?(params)
    avaiable_balance_valid = params.key?(:available_balance) ?
                             numeric_validation(params[:available_balance]) : true
    total_balance_valid = params.key?(:total_balance) ?
                          numeric_validation(params[:total_balance]) : true
    creation_date_valid = params.key?(:creation_date) ?
                          datetime_validation(params[:creation_date]) : true
    if avaiable_balance_valid && total_balance_valid &&
       creation_date_valid
      return true
    else
      return false
    end
 end
end
