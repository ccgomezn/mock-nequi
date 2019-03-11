require_relative '../../db/db_handler'
require_relative '../modules/validate_data'
require_relative '../models/account'
class PocketManager
    include ValidateData

    def initialize(db_handler)
        @db_handler = db_handler
    end

    def valid_data?(*data)
        id_valid = numeric_validation(data[0])
        name_valid = name_validation(data[1])
        goal_valid = numeric_validation(data[2])
        balance_valid = numeric_validation(data[3])
        creation_date_valid = datetime_validation(data[4])
        account_id_valid = numeric_validation(data[5])
        

        if (id_valid and name_valid and goal_valid and \
            balance_valid creation_date_valid and account_id_valid)
            return true
        else
            return false
        end
    end
    
    def insert(*data)
                
        if valid_data?(data)
            data_dict = {id: data[0], name: data[1], goal: data[2],
                        balance: data[3], creation_date: data[4], account_id: data[5]}
            insert_execution("pockets", data_dict)
            return Pocket.new()
        else
            print("ERROR: couldn't insert account data")
        end
    end

    def find(id)
        find_execution("pockets", id)
        return Pocket.new()
    end
    
    #UPDATE And DELETE builders need a dict with the columns and values, if empty value = nil
    def update(id, *data)
        data_dict = {name: data[0], goal: data[1], balance: data[2], 
                     creation_date: data[3], account_id: data[4]}
        update_execution("pockets", data_dict, id)
    end

    def delete(id)
        delete_execution("pockets", id)
    end
end