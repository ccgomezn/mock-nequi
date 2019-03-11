require_relative '../../db/db_handler'
require_relative '../modules/validate_data'
require_relative '../models/account'
class GoalManager
    include ValidateData

    def initialize(db_handler)
        @db_handler = db_handler
    end

    def valid_data?(*data)
        id_valid = numeric_validation(data[0])
        name_valid = name_validation(data[1])
        goal_valid = numeric_validation(data[2])
        balance_valid = numeric_validation(data[3])
        state_valid = name_validation(data[4])
        deadline_valid = datetime_validation(data[5])
        creation_date_valid = datetime_validation(data[6])
        account_id_valid = numeric_validation(data[7])
        

        if (id_valid and name_valid and goal_valid and \
            balance_valid and state_valid and deadline_valid and \
            creation_date_valid and account_id_valid)
            return true
        else
            return false
        end
    end
    
    def insert(*data)
                
        if valid_data?(data)
             data_dict = {id: data[0], name: data[1], goal: data[2],
                        balance: data[3], state: data[4], deadline: data[5],
                        creation_date: data[6], account_id: data[7]}
            insert_execution("goals", data_dict)
            return Goal.new()
        else
            print("ERROR: couldn't insert account data")
        end
    end

    def find(id)
        find_execution("goals", id)
        return Goal.new()
    end
    
    #UPDATE And DELETE builders need a dict with the columns and values, if empty value = nil
    def update(id, *data)
        data_dict = {name: data[0], goal: data[1],
                        balance: data[2], state: data[3], deadline: data[4],
                        creation_date: data[5], account_id: data[6]}
        update_execution("goals", data_dict, id)
    end

    def delete(id)
        delete_execution("accounts", id)
    end
end