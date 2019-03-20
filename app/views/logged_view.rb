require_relative 'helpers/cli_menu_builder'
require_relative 'account_view'
require_relative '../controllers/account_controller'
require_relative 'principal_goal_view'
require_relative '../controllers/goal_controller'
require_relative 'mattress_view'
require_relative '../controllers/mattress_controller'
require_relative 'principal_pocket_view'
require_relative '../controllers/pocket_controller'
require_relative 'transaction_view'
require_relative '../controllers/transaction_controller'
require_relative 'principal_view'

class LoggedView
    include CliMenuBuilder

    def initialize()
        logged_menu()
    end
    
    private 
    def logged_menu()
        # this is for filling the layout in the description
        # the library don't support inserting text 
        title = "Bienvenid@ a tu cuenta nequi!"
        title = title.center(title.length + 40)
        
        menu = basic_menu(title)
        
        account_controller = AccountController.new()
        menu.add('Cuenta de ahorros') do |selected|
            AccountView.new(account_controller)
        end
        menu.add('Mis transacciones') do |selected|
            transaction_controller = TransactionController.new()
            TransactionView.new(transaction_controller)
        end
        menu.add('Metas') do |selected|
            goal_controller = GoalController.new()
            PrincipalGoalView.new(account_controller, goal_controller)
        end
        menu.add('Colchon') do |selected|
            mattress_controller = MattressController.new()
            MattressView.new(account_controller, mattress_controller)
        end
        menu.add('Bolsillos') do |selected|
            pocket_controller = PocketController.new()
            PrincipalPocketView.new(account_controller, pocket_controller)
        end
        menu.add('Cerrar sesion') do |selected|
            PrincipalView.new()
        end

        menu.show
    end
end