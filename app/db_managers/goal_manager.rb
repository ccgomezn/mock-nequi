require_relative 'helpers/validate_data'
require_relative '../models/goal'
require_relative 'helpers/sql_query_executor'

class GoalManager
    include ValidateData
    include SqlQueryExecutor

    def insert(params)
                
        if valid_data?(params)
            if(insert_execution("goals", params))
                goal_id = get_last_register_execution('goals')
                params[:id] = goal_id[0]
                Goal.new(params)
            else
                false
            end
        else
            false
        end
    end
    
    def find_all(account_id)
        find_all_by_column_execution("goals","account_id", account_id)
    end

    def find(id)
        data_query = find_execution('goals', id)
        data_goal = { id: data_query[0], name: data_query[1],
                      goal: data_query[2], balance: data_query[3],
                      state: data_query[4], deadline: data_query[5],
                      creation_date: data_query[6], account_id: data_query[7] }
        return Goal.new(data_goal)
    end
    
    #UPDATE And DELETE builders need a dict with the columns and values, if empty value = nil
    def update(id, params)
        if valid_data?(params)
            update_execution("goals", params, id)
        else
            print("ERROR: couldn't insert account data")
        end
    end

    def delete(id)
        delete_execution("goals", id)
    end

    private

    def valid_data?(params)
        
        goal_valid = params.has_key?(:goal) ? 
                     numeric_validation(params[:goal]) : true
        balance_valid = params.has_key?(:balance) ? 
                        numeric_validation(params[:balance]) : true
        
        deadline_valid = params.has_key?(:deadline) ?
                         datetime_validation(params[:deadline]) : true
        creation_date_valid = params.has_key?(:creation_date) ?
                              datetime_validation(params[:creation_date]) : true
        account_id_valid = params.has_key?(:account_id) ?
                           numeric_validation(params[:account_id]) : true
        

        if (goal_valid and \
            balance_valid and deadline_valid and \
            creation_date_valid and account_id_valid)
            return true
        else
            return false
        end
    end

end