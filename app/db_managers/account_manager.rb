require_relative '../modules/validate_data'
require_relative '../models/account'
require_relative '../modules/sql_query_executor'

class AccountManager
    include ValidateData
    include SqlQueryExecutor


    def initialize(db_handler)
        @db_handler = db_handler	      
    end
    
    def insert(params)                
        if valid_data?(params)
            
            insert_execution("accounts", params)
            return Account.new()
        else
            print("ERROR: couldn't insert account data")
        end
    end

    def find(id)
        find_execution("accounts", id)
        return Account.new()
    end
    
    #UPDATE And DELETE builders need a dict with the columns and values, if empty value = nil
    def update(id, params)
        if valid_data?(params)
            update_execution("accounts", params, id)
        else
            print("ERROR: couldn't insert account data")
        end
    end

    def delete(id)
        delete_execution("accounts", id)
    end

    private 

     def valid_data?(params)

        avaiable_balance_valid = params.has_key?(:available_balance) ? 
                                 numeric_validation(params[:available_balance]) : true
        total_balance_valid = params.has_key?(:total_balance) ? 
                              numeric_validation(params[:total_balance]) : true
        creation_date_valid = params.has_key?(:creation_date) ? 
                              datetime_validation(params[:creation_date]) : true
        if (avaiable_balance_valid and total_balance_valid and 
            creation_date_valid)
            return true
        else
            return false
        end
    end
    
end

