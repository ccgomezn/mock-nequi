require 'date'
require 'bigdecimal'

module ValidateData

    def validate_regex(regex, data_value, error)
        if regex.match(data_value) == nil
            return false
        else 
            return true
        end
    end
    
    def email_validation(email_str)
        email_regex = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
        email_error = "ERROR: email format is not valid."
        
        validate_regex(email_regex, email_str, email_error)
    end        

    def name_validation(name_str)
        name_regex = /\A([A-Za-z ]+)\z/
        name_error = "ERROR: name format is not valid"

        validate_regex(name_regex, name_str, name_error)
    end

    def location_validation(location_str)
        location_regex = /\A([\w ]+[\- ]+[\w ]+)\z/
        location_error = "ERROR: location format is not valid"

        validate_regex(location_regex, location_str, location_error)
    end

    def datetime_validation(datetime_str)     
        begin 
            DateTime.strptime(datetime_str, '%Y-%m-%d %H:%M:%S')
            return true
        rescue
            return false
        end
    end

    def numeric_validation(numeric_value)
        if numeric_value.is_a? Numeric
            return true
        else
            return false
        end
    end
    
end