require_relative 'query_error_builder'
require_relative 'sql_query_builder'

module SqlQueryExecutor
    include QueryErrorBuilder
    include SqlQueryBuilder

    def find_execution(table_name, id)
        find_query = find_query(table_name)

        execute_query(find_query, id, find_error())
    end

    def find_by_column_execution(table_name, column, data)
        find_query = find_query_by_column(table_name, column)

        execute_query(find_query, data, find_error())
    end

    def find_all_execution(table_name)
        find_query = find_all_query(table_name)

        execute_query(find_query, [], find_error())
    end

    def insert_execution(table_name, data)
        columns = data.keys
        values = data.values
        insert_query = insert_query(table_name, columns)
        
        execute_query(insert_query, values, insert_error())
    end        

    def update_execution(table_name, data, id)
        columns = data.keys
        values = data.values
        values.push(id)
        update_query = update_query(table_name, columns)
    
        execute_query(update_query, values, update_error())
    end

    def delete_execution(table_name, id)
        delete_query = delete_query(table_name)

        execute_query(delete_query, id, delete_error())
    end

    def get_last_register_execution(table_name)
        get_last_register = get_last_register_query(table_name)
        execute_query(get_last_register, [], find_error())

    end

    def execute_query(query, values, query_error)
        begin
            db = $db_connection
            query_stmt = db.prepare(query)
            response = query_stmt.execute(values)
            response = response.next
        rescue SQLite3::Exception => sql_error
            puts(query_error)
            puts(sql_error)
        ensure
            stmt_close(query_stmt)
            return response
        end
    end

    def stmt_close(stmt)
        if stmt
            stmt.close
        end
    end
end