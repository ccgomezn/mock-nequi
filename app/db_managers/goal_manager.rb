require_relative '../modules/validate_data'
require_relative '../models/account'
require_relative '../modules/sql_query_executor'

class GoalManager
    include ValidateData
    include SqlQueryExecutor

    def initialize(db_handler)
        @db_handler = db_handler	      
    end


    def insert(params)
                
        if valid_data?(params)
            insert_execution("goals", params)
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
    def update(id, params)
        if valid_data?(params)
            update_execution("goals", data_dict, id)
        else
            print("ERROR: couldn't insert account data")
        end
    end

    def delete(id)
        delete_execution("accounts", id)
    end

    private

    def valid_data?(params)
        name_valid = params.has_key?(:name) ?
                     name_validation(params[:name]) : true
        goal_valid = params.has_key?(:goal) ? 
                     numeric_validation(params[:goal]) : true
        balance_valid = params.has_key?(:balance) ? 
                        numeric_validation(params[:balance]) : true
        state_valid = params.has_key?(:state) ?
                      name_validation(params[:state]) : true
        deadline_valid = params.has_key?(:deadline) ?
                         datetime_validation(params[:deadline]) : true
        creation_date_valid = params.has_key?(:creation_date) ?
                              datetime_validation(params[:creation_date]) : true
        account_id_valid = params.has_key?(:account_id) ?
                           numeric_validation(params[:account_id]) : true
        

        if (name_valid and goal_valid and \
            balance_valid and state_valid and deadline_valid and \
            creation_date_valid and account_id_valid)
            return true
        else
            return false
        end
    end

end