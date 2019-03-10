module SqlQueryBuilder

    def find_query(table_name)
        find_query = "SELECT * FROM #{table_name} WHERE #{table_name}.id = ?"
    end

    def insert_query(table_name, columns)
        column_string = ""
        values_string = ""

        columns.each_with_index do |column, i|
            if i < columns.length - 1
                column_string += "#{column}, "
                values_string += "?, "
            else
                column_string += "#{column}"
                values_string += "?"
            end
        end

        insert_query = "INSERT INTO #{table_name}(#{column_string})"\
                        " VALUES(#{values_string})"
    end

    def update_query(table_name, columns)
        column_value_string = ""
        
        columns.each_with_index do |column, i|
            if i < columns.length - 1
                column_value_string += "#{column} = ?, "
            else
                column_value_string += "#{column} = ?"
            end
        end
        
        update_query = "UPDATE #{table_name} SET #{column_value_string}"\
                        " WHERE #{table_name}.id = ?"
    end

    def delete_query(table_name)
        delete_query = "DELETE FROM #{table_name} WHERE #{table_name}.id = ?"
    end

end