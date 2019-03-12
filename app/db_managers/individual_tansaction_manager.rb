require_relative '../../db/db_handler'
require_relative '../modules/validate_data'
require_relative '../models/account'
class IndividualTransactionManager
    include ValidateData

    def initialize(db_handler)
        @db_handler = db_handler
    end

    def valid_data?(*data)
        id_valid = numeric_validation(data[0])
        product_valid = name_validation(data[1])
        location_valid = name_validation(data[2])
        transaction_id_valid = numeric_validation(data[3])
        account_id_valid = name_validation(data[4])
        
        

        if (id_valid and product_valid and location_valid and \
            transaction_id_valid and account_id_valid)
            return true
        else
            return false
        end
    end
    
    def insert(*data)
                
        if valid_data?(data)
             data_dict = {id: data[0], product: data[1], location: data[2],
                        transaction_id: data[3], account_id: data[4]}
            insert_execution("individual_transactions", data_dict)
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
    def update(id, *data)
        data_dict = {product: data[0], location: data[1],
                        transaction_id: data[2], account_id: data[3]}
        update_execution("individual_transactions", data_dict, id)
    end

    def delete(id)
        delete_execution("individual_transactions", id)
    end
end