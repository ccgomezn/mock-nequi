require_relative 'db/db_handler'
require_relative 'app/controllers/account_controller'
require_relative 'app/views/principal_view'
require_relative 'app/controllers/pocket_controller'

$session = {}

# initializes the db with the given name and create it if does not exists
db_handler = DbHandler.instance
$db_connection = db_handler.db
$db_connection.freeze

menu = PrincipalView.new
