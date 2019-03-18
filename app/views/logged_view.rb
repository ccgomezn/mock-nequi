require_relative '../modules/cli_menu_builder'
require_relative 'account_view'
require_relative 'goal_view'
require_relative 'mattress_view'
require_relative 'pocket_view'
require_relative 'transaction_view'
require_relative 'principal_view'

class LoggedView
    include CliMenuBuilder

    def initialize()
        logged_menu()
    end
    
    def logged_menu()
        # this is for filling the layout in the description
        # the library don't support inserting text 
        title = "Bienvenid@ a tu cuenta nequi!"
        title = title.center(title.length + 40)
        blankspace = " "
        description = "Saldo total: " + blankspace*56 
        description += "\n Saldo disponible: " + blankspace*50

        menu = basic_menu(title, description)

        menu.add('Cuenta de ahorros') do |selected|
            AccountView.new()
        end
        menu.add('Mis transacciones') do |selected|
            TransactionView.new()
        end
        menu.add('Metas') do |selected|
            GoalView.new()
        end
        menu.add('Colchon') do |selected|
            MattressView.new()
        end
        menu.add('Bolsillos') do |selected|
            PocketView.new()
        end
        menu.add('Regresar') do |selected|
            PrincipalView.new()
        end

        menu.show
    end
end