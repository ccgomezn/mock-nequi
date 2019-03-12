require_relative '../../db/db_handler'
require_relative '../modules/validate_data'
require_relative '../models/account'

class AccountManager
    include ValidateData

    def initialize(db_handler)
        @db_handler = db_handler
    end

    def valid_data?(*data)
        id_valid = numeric_validation(data[0])
        avaiable_balance_valid = numeric_validation(data[1])
        total_balance_valid = numeric_validation(data[2])
        creation_date_valid = datetime_validation(data[3])

        if (id_valid and avaiable_balance_valid and total_balance_valid and \
            creation_date_valid)
            return true
        else
            return false
        end
    end
    
    def insert(*data)                
        if valid_data?(data)
             data_dict = {id: data[0], avaiable_balance: data[1], total_balance: data[2],
                        creation_date: data[3]}
            insert_execution("accounts", data_dict)
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
    def update(id, *data)
        data_dict = {avaiable_balance: data[0], total_balance: data[1],
                        creation_date: data[2]}
        update_execution("accounts", data_dict, id)
    end

    def delete(id)
        delete_execution("accounts", id)
    end
end