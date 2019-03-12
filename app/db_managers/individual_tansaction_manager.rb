require_relative '../modules/validate_data'
require_relative '../models/account'
require_relative '../modules/sql_query_executor'

class IndividualTransactionManager
    include ValidateData
    include SqlQueryExecutor

    def insert(params)
                
        if valid_data?(params)
            
            insert_execution("individual_transactions", params)
            return IndividualTransaction.new()
        else
            print("ERROR: couldn't insert account data")
        end
    end

    def find(id)
        find_execution("individual_transactions", id)
        return IndividualTransaction.new()
    end
    
    #UPDATE And DELETE builders need a dict with the columns and values, if empty value = nil
    def update(id, params)
        if valid_data?(params)
            update_execution("individual_transactions", params, id)
        else
            print("ERROR: couldn't insert account data")
        end
    end

    def delete(id)
        delete_execution("individual_transactions", id)
    end

    private

     def valid_data?(params)
        product_valid = params.has_key?(:product) ?
                        name_validation(params[:product]) : true
        location_valid = params.has_key?(:location) ?
                         name_validation(params[:location]) : true
        transaction_id_valid = params.has_key?(:transaction_id) ?
                               numeric_validation(params[:transaction_id]) : true
        account_id_valid = params.has_key?(:account_id) ?
                          numeric_validation(params[:account_id]) : true
        
        

        if (id_valid and product_valid and location_valid and \
            transaction_id_valid and account_id_valid)
            return true
        else
            return false
        end
    end

end