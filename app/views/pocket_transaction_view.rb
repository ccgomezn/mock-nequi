require_relative 'helpers/cli_menu_builder'
require_relative 'helpers/cli_input'
require_relative 'list_pocket_view'
require 'tty-prompt'

class PocketTransactionView
    include CliInput
    include CliMenuBuilder

    def initialize(pocket_controller, pocket)
        @pocket_controller = pocket_controller
        @pocket = pocket
        @prompt = TTY::Prompt.new(help_color: :cyan, active_color: :bright_magenta)

        pocket_transaction_menu()
    end
    
    private
    def pocket_transaction_menu()
        # this is for filling the layout in the description
        # the library don't support inserting text 
        title = @pocket[1]
        title = title.center(title.length + 57)

        menu = basic_menu(title)
        
        menu.add('Cargar bolsillo') do
            transaction_param = ask_params("Valor")
            amount = transaction_param["Valor"].to_f
            pocket_id = @pocket[0]
            @pocket_controller.debit(amount, pocket_id, "virtual-virtual")
            @prompt.ok("Carga Exitosa!")
            
            sleep(2)
            pocket_transaction_menu()
        end
        menu.add('Descargar bolsillo') do
            transaction_param = ask_params("Valor")
            amount = transaction_param["Valor"].to_f
            pocket_id = @pocket[0]
            @pocket_controller.withdraw(amount, pocket_id, "virtual-virtual")
            @prompt.ok("Descarga Exitosa!")
            
            sleep(2)
            pocket_transaction_menu()
        end
        menu.add('Eliminar bolsillo') do
        
        end
        menu.add('Regresar') do
            ListPocketView.new(@pocket_controller)
        end
        
        menu.show
    end
end