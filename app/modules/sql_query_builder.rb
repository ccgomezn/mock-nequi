module SqlQueyBuilder

    def find_builder(id, table)
        db = @db_handler.connect
        db.execute("SELECT * FROM #{table} where id = #{id}")
    end

    def insert_builder(id, table, *data)
        db = @db_handler.connect
        insert_query = insert_builder(table, *data)
        db.execute(insert_query)
    end        

    # update for a given table using a data where the key is the column and the value is the data
    def update_builder(id, table, *data)
        db = @db_handler.connect
        db.execute("UPDATE #{table} SET column = ? WHERE ")
        #db.execute("UPDATE accounts SET creation_date = ? WHERE accounts.id = ?", ["03/06/2019 23:13:20", 1])
    end

    def insert_string_builder(table, *data)
        column_string = ""
        values_string = ""

        data.each_with_index do |values, i|
            if i < data.length - 1
                column_string += "#{data[i]}, "
                values_string += "?, "
            else
                column_string += "#{data[i]}"
                values_string += "?"
            end
        end

        insert_statement = "INSERT INTO #{table}(#{column_string})
                            VALUES(#{values_string})"
    end

    def update_string_builder(table, *data, id)
        update_string = "UPDATE #{table} SET "
    end

    def delete_string_builder(table, id)
    
    end
end