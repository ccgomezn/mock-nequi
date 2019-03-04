require_relative '../../db/db_handler'

#initializes the db with the given name and create it if does not exists
db_folder_path = "../../db/"
@dbHandler = DbHandler.new(db_folder_path, "mock_nequi_db.db")
@dbHandler.create
