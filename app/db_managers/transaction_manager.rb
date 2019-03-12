require_relative '../../db/db_handler'
require_relative '../modules/validate_data'
require_relative '../models/account'
class TransactionManager
    include ValidateData

    def initialize(db_handler)
        @db_handler = db_handler
    end

    def valid_data?(*data)
        id_valid = numeric_validation(data[0])
        date_valid = datetime_validation(data[1])
        amount_valid = numeric_validation(data[2])
       

        if (id_valid and date_valid and amount_valid)
            return true
        else
            return false
        end
    end
    
    def insert(*data)
                
        if valid_data?(data)
            data_dict = {id: data[0], date: data[1], amount: data[2]}
            insert_execution("transactions", data_dict)
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
    def update(id, *data)
        data_dict = {date: data[0], amount: data[1]}
        update_execution("transactions", data_dict, id)
    end

    def delete(id)
        delete_execution("transactions", id)
    end
end