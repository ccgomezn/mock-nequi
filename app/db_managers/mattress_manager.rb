require_relative '../modules/validate_data'
require_relative '../models/mattress'
require_relative '../modules/sql_query_executor'

class MattressManager
    include ValidateData
    include SqlQueryExecutor

    def initialize(db_handler)
        @db_handler = db_handler	      
    end

    def insert(params)
                
        if valid_data?(params)
            insert_execution('mattresses', params)
            matress_id = get_last_register_execution('mattresses')
            params[:id] = matress_id[0]
            Mattress.new(params)
        else
            print("ERROR: couldn't insert account data")
        end
    end

    def find(id)
        data_query = find_execution('mattresses', id)
        data_mattress = { id: data_query[0], balance: data_query[1],
                          account_id: data_query[2] }
        Mattress.new(data_mattress)
    end
    
    #UPDATE And DELETE builders need a dict with the columns and values, if empty value = nil
    def update(id, params)
        if valid_data?(params)
            update_execution("mattresses", params, id)
        else
            print("ERROR: couldn't insert account data")
        end
    end

    def delete(id)
        delete_execution("mattresses", id)
    end

    private

    def valid_data?(params)
        balance_valid = params.has_key?(:balance) ? 
                        numeric_validation(params[:balance]) : true
        account_id_valid = params.has_key?(:account_id) ? 
                           numeric_validation(params[:account_id]) : true
        
        

        if (balance_valid and account_id_valid)
            return true
        else
            return false
        end
    end
end