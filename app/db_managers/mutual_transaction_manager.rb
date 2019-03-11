require_relative '../../db/db_handler'
require_relative '../modules/validate_data'
require_relative '../models/account'
class MutualTransactionManager
    include ValidateData

    def initialize(db_handler)
        @db_handler = db_handler
    end

    def valid_data?(*data)
        id_valid = numeric_validation(data[0])
        transaction_id_valid = name_validation(data[1])
        origin_account_id_valid = numeric_validation(data[2])
        final_account_id_valid = numeric_validation(data[3])
        
        

        if (id_valid and transaction_id_valid and origin_account_id_valid and \
            final_account_id_valid)
            return true
        else
            return false
        end
    end
    
    def insert(*data)
                
        if valid_data?(data)
             data_dict = {id: data[0], transaction_id: data[1], origin_account_id: data[2],
                        final_account_id: data[3]}
            insert_execution("mutual_transactions", data_dict)
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
    def update(id, *data)
        data_dict = {transaction_id: data[0], origin_account_id: data[1],
                        final_account_id: data[2]}
        update_execution("mutual_transactions", data_dict, id)
    end

    def delete(id)
        delete_execution("mutual_transactions", id)
    end
end