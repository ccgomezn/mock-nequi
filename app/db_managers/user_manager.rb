require_relative 'helpers/validate_data'
require_relative '../models/user'
require_relative 'helpers/sql_query_executor'

class UserManager
    include ValidateData
    include SqlQueryExecutor

    def insert(params)
                
        if valid_data?(params)
            if(insert_execution("users", params))
                user_id = get_last_register_execution('users')
                params[:id] = user_id[0]
                User.new(params)
            else
                false
            end
        else
            false
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
            false
        end
    end

    def delete(id)
        delete_execution("users", id)
    end

    def login(email, password)
        data_query = find_by_column_execution("users", "email", email)
        if data_query === nil
            return {state: false}
        end
        
        if(data_query[3] == password)
            return {account_id: data_query[4], state: true}
        end
        return {state: false}
    end

    private

     def valid_data?(params)
        name_valid = params.has_key?(:name) ?
                     name_validation(params[:name]) : true
        email_valid = params.has_key?(:email) ?
                      email_validation(params[:email]) : true
        
        account_id_valid = params.has_key?(:account_id) ?
                           numeric_validation(params[:account_id]) : true
        
        

        if (name_valid and email_valid and \
             account_id_valid)
            return true
        else
            return false
        end
    end
end

