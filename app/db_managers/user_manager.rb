require_relative '../modules/validate_data'
require_relative '../models/user'
require_relative '../modules/sql_query_executor'

class UserManager
    include ValidateData
    include SqlQueryExecutor

    def initialize(db_handler)
        @db_handler = db_handler	      
    end

    def insert(params)
                
        if valid_data?(params)
            insert_execution("users", params)
            user_id = get_last_register_execution('users')
            params[:id] = user_id[0]
            return User.new(params)
        else
            print("ERROR: couldn't insert account data")
        end
    end

    def find(id)
        data_query = find_execution("users", id)
        data_account = {id: data_query[0], name: data_query[1],
                        email: data_query[2], account_id: data_query[4]}
        return User.new(data_account)
    end
    
    #UPDATE And DELETE builders need a dict with the columns and values, if empty value = nil
    def update(id, params)
        if valid_data?(params)
            update_execution("users", params, id)
        else
            print("ERROR: couldn't insert account data")
        end
    end

    def delete(id)
        delete_execution("users", id)
    end

    private

     def valid_data?(*data)
        name_valid = params.has_key?(:name) ?
                     name_validation(params[:name]) : true
        email_valid = params.has_key?(:email) ?
                      name_validation(params[:email]) : true
        password_digest_valid = params.has_key?(:password_digest) ?
                                name_validation(params[:password_digest]) : true
        account_id_valid = params.has_key?(:account_id) ?
                           numeric_validation(params[:account_id]) : true
        
        

        if (name_valid and email_valid and \
            password_digest_valid and account_id_valid)
            return true
        else
            return false
        end
    end
end

