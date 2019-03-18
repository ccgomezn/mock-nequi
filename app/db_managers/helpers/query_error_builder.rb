module QueryErrorBuilder
    
    def status_message(code)
        status = "status: #{code}" 
    end

    #generic "bad request" status
    def bad_request_status
       status_message(400)
    end

    def error_message(query_type)
        error_status = bad_request_status()
        error_message = "#{error_status}, #{query_type} query error."
    end

    def find_error
        error_message("Find")
    end

    def insert_error
        error_message("Insertion")
    end

    def update_error
        error_message("Update")
    end

    def delete_error
        error_message("Deletion")
    end
end