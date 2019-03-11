#require_relative '../db_managers/account_manager'
require_relative '../../db/db_handler'
require_relative '../modules/sql_query_executor'

include SqlQueryExecutor
#initializes the db with the given name and create it if does not exists
db_folder_path = "../../db/"
@db_handler = DbHandler.new(db_folder_path, "mock_nequi_db.db")
@db_handler.create
#db = @dbHandler.connect

insert_data = {avaiable_balance: 1000, total_balance: 2000, creation_date: "03/06/2019 23:13:20"}
update_data = {avaiable_balance: 0}

#Trying all the basic queries from query executor

#p insert_execution("accounts", insert_data)
#p update_execution("accounts", update_data, 2)
#p find_execution("accounts", 2)
#p delete_execution("accounts", 1)
