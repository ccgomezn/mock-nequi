require_relative '../modules/cli_menu_builder'
require_relative 'logged_view'
require 'tty-prompt'

class AccountView
    include CliMenuBuilder

    def initialize(account_controller)
        @account_controller = account_controller
        account_menu()
    end
    
    def account_menu()
        # this is for filling the layout in the description
        # the library don't support inserting text 
        title = "Cuenta de ahorros"
        title = title.center(title.length + 50)
        
        menu = basic_menu(title)

        menu.add('Consignar a cuenta') do |selected|
            p selected
        end
        menu.add('Descargar cuenta') do |selected|
            p selected
        end
        menu.add('Regresar') do |selected|
            LoggedView.new()
        end
        
        menu.show
    end
end