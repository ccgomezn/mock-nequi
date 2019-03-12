require_relative '../../db/db_handler'
require_relative '../modules/validate_data'
require_relative '../models/account'
class UserManager
    include ValidateData

    def initialize(db_handler)
        @db_handler = db_handler
    end

    def valid_data?(*data)
        id_valid = numeric_validation(data[0])
        name_valid = name_validation(data[1])
        email_valid = ename_validation(data[2])
        password_digest_valid = name_validation(data[3])
        account_id_valid = numeric_validation(data[4])
        
        

        if (id_valid and name_valid and email_valid and \
            password_digest_valid and account_id_valid)
            return true
        else
            return false
        end
    end
    
    def insert(*data)
                
        if valid_data?(data)
            data_dict = {id: data[0], name: data[1], email: data[2],
                        password_digest: data[3], account_id: data[4]}
            insert_execution("users", data_dict)
            return User.new()
        else
            print("ERROR: couldn't insert account data")
        end
    end

    def find(id)
        find_execution("users", id)
        return User.new()
    end
    
    #UPDATE And DELETE builders need a dict with the columns and values, if empty value = nil
    def update(id, *data)
        data_dict = {name: data[0], email: data[1],
            password_digest: data[2], account_id: data[3]}
        update_execution("users", data_dict, id)
    end

    def delete(id)
        delete_execution("users", id)
    end
end