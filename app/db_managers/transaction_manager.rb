require_relative '../modules/validate_data'
require_relative '../models/account'
require_relative '../modules/sql_query_executor'

class TransactionManager
    include ValidateData
    include SqlQueryExecutor

    def insert(params)
                
        if valid_data?(params)
            insert_execution("transactions", params)
            return Transaction.new()
        else
            print("ERROR: couldn't insert account data")
        end
    end

    def find(id)
        find_execution("transactions", id)
        return Transaction.new()
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