require_relative '../../db/db_handler'
require_relative '../modules/validate_data'
require_relative '../models/account'
class MattressManager
    include ValidateData

    def initialize(db_handler)
        @db_handler = db_handler
    end

    def valid_data?(*data)
        id_valid = numeric_validation(data[0])
        balance_valid = numeric_validation(data[1])
        account_id_valid = numeric_validation(data[2])
        
        

        if (id_valid and balance_valid and account_id_valid)
            return true
        else
            return false
        end
    end
    
    def insert(*data)
                
        if valid_data?(data)
            data_dict = {id: data[0], balance: data[1], account: data[2]}
            insert_execution("mattresses", data_dict)
            return Mattresses.new()
        else
            print("ERROR: couldn't insert account data")
        end
    end

    def find(id)
        find_execution("mattresses", id)
        return Mattresses.new()
    end
    
    #UPDATE And DELETE builders need a dict with the columns and values, if empty value = nil
    def update(id, *data)
        data_dict = {balance: data[0], account: data[1]}
        update_execution("mattresses", data_dict, id)
    end

    def delete(id)
        delete_execution("mattresses", id)
    end
end