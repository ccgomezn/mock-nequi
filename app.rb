# require_relative 'app/db_managers/account_manager'
require_relative 'db/db_handler'
require_relative 'app/controllers/account_controller'
require_relative 'app/views/principal_view'
require_relative 'app/controllers/pocket_controller'

$session = {}
# initializes the db with the given name and create it if does not exists
db_handler = DbHandler.instance
$db_connection = db_handler.db
$db_connection.freeze

# pc = PocketController.new()
# pc.find_all()

# ac.debit(100, 1, "virtual-virtual")

menu = PrincipalView.new
# menu = SignUpView.new()
# menu.show()

# insert_data = {avaiable_balance: 1000, total_balance: 2000, creation_date: "03/06/2019 23:13:20"}
# update_data = {avaiable_balance: 0}

# Trying all the basic queries from query executor

# p insert_execution("accounts", insert_data)
# p update_execution("accounts", update_data, 2)
# p find_execution("accounts", 2)
# p delete_execution("accounts", 1)
