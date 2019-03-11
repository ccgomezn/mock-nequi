require_relative '../../db/db_handler'
require_relative '../modules/validate_data'
require_relative 'manager_interface'
require_relative '../models/account'
class AccountManager
    include ValidateData
    include ManagerInferface

    def initialize(db_handler)
        @db_handler = db_handler
    end

    def valid_data?(*data)
        avaiable_balance_valid = numeric_validation(data[0])
        total_balance_valid = numeric_validation(data[1])
        creation_date_valid = datetime_validation(data[2])

        if (avaiable_balance_valid and total_balance_valid and \
            creation_date_valid)
            return true
        else
            return false
        end
    end
    
    def insert(*data)
        insert_builder(data[0], "accounts", data[1...data.length])
        return Account.new()
    end

    def find(id)
        find_builder(id, "accounts")
        return Account.new()
    end
    
    #UPDATE And DELETE builders need a dict with the columns and values, if empty value = nil
    def update(id, *data)
        if data.length
        data_dict = {avaiable_balance: *data[0], total_balance: *data[1],
                        creation_date: *data[2]}
        update_builder(id, "accounts", data_dict)
    end

    def delete(id, *data)
    end
end