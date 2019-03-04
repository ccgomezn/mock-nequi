require_relative '../models/account'
require_relative '../../db/db_handler'

#initializes the db with the given name and create it if does not exists
db_folder_path = "../../db/"
@dbHandler = DbHandler.new(db_folder_path, "mock_nequi_db.db")
@dbHandler.create

acc = Account.new(@dbHandler)

acc.insert(1000000, 2000000, "03/04/2019 18:25:00")
