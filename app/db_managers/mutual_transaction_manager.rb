require_relative '../modules/validate_data'
require_relative '../models/account'
require_relative '../modules/sql_query_executor'

class MutualTransactionManager
    include ValidateData
    include SqlQueryExecutor

    def initialize(db_handler)
        @db_handler = db_handler	      
    end

    def insert(params)
                
        if valid_data?(params)
             
            insert_execution("mutual_transactions", params)
            return MutualTransaction.new()
        else
            print("ERROR: couldn't insert account data")
        end
    end

    def find(id)
        find_execution("mutual_transactions", id)
        return MutualTransaction.new()
    end
    
    #UPDATE And DELETE builders need a dict with the columns and values, if empty value = nil
    def update(id, params)
        if valid_data?(params)
            update_execution("mutual_transactions", params, id)
        else
            print("ERROR: couldn't insert account data")
        end
    end

    def delete(id)
        delete_execution("mutual_transactions", id)
    end

    private

    def valid_data?(params)
        transaction_id_valid = params.has_key?(:name) ? 
                               numeric_validation(params[:name]) : true
        origin_account_id_valid = params.has_key?(:origin_account) ? 
                                  numeric_validation(params[:origin_account]) : true
        final_account_id_valid = params.has_key?(:final_account) ? 
                                 numeric_validation(params[:final_account]) : true
        
        

        if (transaction_id_valid and origin_account_id_valid and \
            final_account_id_valid)
            return true
        else
            return false
        end
    end
end