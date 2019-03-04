require_relative '../../db/db_handler'
require_relative '../modules/validate_data'

class Account
    include ValidateData

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
        db = @db_handler.connect
        
        avaiable_balance = data[0]
        total_balance = data[1]
        creation_date = data[2]
        
        if valid_data?(*data)
            db.execute("INSERT INTO accounts(avaiable_balance, total_balance, 
                creation_date) VALUES(?, ?, ?)", 
                [avaiable_balance, total_balance, creation_date])
        else
            print("ERROR: couldn't insert account data")
        end
    end

end



