require_relative 'helpers/validate_data'
require_relative '../models/pocket'
require_relative 'helpers/sql_query_executor'

class PocketManager
  include ValidateData
  include SqlQueryExecutor

  def insert(params)
    if valid_data?(params)
      if insert_execution('pockets', params)
        pocket_id = get_last_register_execution('pockets')
        params[:id] = pocket_id[0]
        Pocket.new(params)
      else
        false
      end
    else
      false
    end
  end

  def find(id)
    data_query = find_execution('pockets', id)
    data_pocket = { id: data_query[0], name: data_query[1],
                    balance: data_query[2], creation_date: data_query[3],
                    account_id: data_query[4] }
    Pocket.new(data_pocket)
  end

  def find_all(account_id)
    find_all_by_column_execution('pockets', 'account_id', account_id)
  end

  # UPDATE And DELETE builders need a dict with the columns and values, if empty value = nil
  def update(id, params)
    if valid_data?(params)
      update_execution('pockets', params, id)
    else
      print("ERROR: couldn't insert account data")
    end
  end

  def delete(id)
    delete_execution('pockets', id)
  end

  private

  def valid_data?(params)
    balance_valid = params.key?(:balance) ?
                    numeric_validation(params[:balance]) : true
    creation_date_valid = params.key?(:creation_date) ?
                          datetime_validation(params[:creation_date]) : true
    account_id_valid = params.key?(:account_id) ?
                       numeric_validation(params[:account_id]) : true

    if balance_valid && creation_date_valid && account_id_valid
      return true
    else
      return false
    end
  end
end
