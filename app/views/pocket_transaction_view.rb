require_relative 'helpers/cli_menu_builder'
require_relative 'helpers/cli_input'
require_relative 'logged_view'
require_relative 'pocket_view'
require_relative 'list_pocket_view'
require 'tty-prompt'

class PocketTransactionView
    include CliMenuBuilder

    def initialize(pocket_controller, pocket)
        @pocket_controller = pocket_controller
        @pocket = pocket

        pocket_transaction_menu()
    end
    
    private
    def pocket_transaction_menu()
        # this is for filling the layout in the description
        # the library don't support inserting text 
        title = @pocket["name"]
        title = title.center(title.length + 45)

        menu = basic_menu(title)
        
        
        menu.add('Cargar bolsillo') do
            
        end
        menu.add('Descargar bolsillo') do
            
        end
        menu.add('Eliminar bolsillo') do
        
        end
        menu.add('Regresar') do
            ListPocketView.new()
        end
        
        menu.show
    end
end