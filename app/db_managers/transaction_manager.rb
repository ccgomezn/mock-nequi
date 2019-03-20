require_relative 'helpers/validate_data'
require_relative '../models/transaction'
require_relative 'helpers/sql_query_executor'

class TransactionManager
    include ValidateData
    include SqlQueryExecutor

    def insert(params)
                
        if valid_data?(params)
            insert_execution('transactions', params)
            transaction_id = get_last_register_execution('transactions')
            params[:id] = transaction_id[0]
            Transaction.new(params)
        else
            print("ERROR: couldn't insert account data")
        end
    end

    def find(id)
        find_execution('transactions', id)
        return Transaction.new()
    end

    def get_all_transactions(account_id)
        individual_transactions = find_all_column_join_execution("individual_transaction", "transaction","account_id", account_id)
        mutual_transactions_out = find_all_column_join_execution("mutual_transaction", "transaction","origin_account_id", account_id)
        mutual_transactions_in = find_all_column_join_execution("mutual_transaction", "transaction", "final_account_id", account_id)
        data = { individual_transactions: individual_transactions,
                 mutual_transactions_in: mutual_transactions_in,
                 mutual_transactions_out: mutual_transactions_out }
        data
    end
    
    #UPDATE And DELETE builders need a dict with the columns and values, if empty value = nil
    def update(id, params)
        if valid_data?(params)
            update_execution("transactions", params, id)
        else
            print("ERROR: couldn't insert account data")
        end
    end

    def delete(id)
        delete_execution("transactions", id)
    end

    private

    def valid_data?(params)
        date_valid = params.has_key?(:date) ? 
                     datetime_validation(params[:date]) : true
        amount_valid = params.has_key?(:amount) ? 
                       numeric_validation(params[:amount]) : true
       

        if (date_valid and amount_valid)
            return true
        else
            return false
        end
    end
    
end