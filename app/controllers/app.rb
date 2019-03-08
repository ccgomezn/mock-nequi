#require_relative '../db_managers/account_manager'
require_relative '../../db/db_handler'

#initializes the db with the given name and create it if does not exists
db_folder_path = "../../db/"
@dbHandler = DbHandler.new(db_folder_path, "mock_nequi_db.db")
@dbHandler.create
db = @dbHandler.connect

db.execute("UPDATE accounts SET creation_date = ? WHERE accounts.id = ?", ["03/06/2019 23:13:20", 1])