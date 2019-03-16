require_relative '../modules/cli_menu_builder'
require_relative 'logged_view'
require 'tty-prompt'

class TransactionView
    include CliMenuBuilder

    def initialize(transaction_controller)
        @transaction_controller = transaction_controller
        transaction_menu()
    end
    
    def transaction_menu()
        # this is for filling the layout in the description
        # the library don't support inserting text 
        title = "Transacciones"
        title = title.center(title.length + 57)

        menu = basic_menu(title)

        menu.add('Regresar') do |selected|
            LoggedView.new()
        end
        menu.show
    end
end