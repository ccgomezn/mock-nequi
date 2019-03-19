require_relative 'helpers/cli_menu_builder'
require_relative 'helpers/cli_input'
require_relative 'logged_view'
require 'tty-prompt'

class MattressView
    include CliInput
    include CliMenuBuilder

    def initialize(account_controller, mattress_controller)
        @account_controller = account_controller
        @mattress_controller = mattress_controller
        @prompt = TTY::Prompt.new(help_color: :cyan, active_color: :bright_magenta)

        mattress_menu()
    end

    def mattress_menu()
        # this is for filling the layout in the description
        # the library don't support inserting text 
        title = "Colchon"
        title = title.center(title.length + 63)

        menu = basic_menu(title)

        menu.add('Consultar saldo') do |selected|
            balance = @mattress_controller.get_balance()
            @prompt.ok('El saldo del colchon es: ' + balance.to_s)
                        
            sleep(3)
            mattress_menu()
        end
        menu.add('Cargar colchon') do |selected|
            acc_balance = @account_controller.get_balance()
            available_acc_balance = acc_balance[:available]
            transaction_param = ask_valid_transaction("Valor",
                                                      available_acc_balance)
            amount = transaction_param.to_f
            @mattress_controller.debit(amount)
            @prompt.ok("Carga Exitosa!")
            
            sleep(1)
            mattress_menu()
        end
        menu.add('Descargar colchon') do |selected|
            mat_balance = @mattress_controller.get_balance()
            transaction_param = ask_valid_transaction("Valor", mat_balance)
            amount = transaction_param.to_f
            @mattress_controller.withdraw(amount)
            @prompt.ok("Descarga Exitosa!")
            
            sleep(1)
            mattress_menu()
        end
        menu.add('Regresar') do |selected|
            LoggedView.new()
        end
        
        menu.show
    end
end