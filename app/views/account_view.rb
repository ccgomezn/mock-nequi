require_relative 'helpers/cli_menu_builder'
require_relative 'helpers/cli_input'
require_relative 'logged_view'
require 'tty-prompt'

class AccountView
    include CliInput
    include CliMenuBuilder

    def initialize(account_controller)
        @account_controller = account_controller
        @prompt = TTY::Prompt.new(help_color: :cyan, active_color: :bright_magenta)

        account_menu()
    end
    
    private
    def account_menu()
        # this is for filling the layout in the description
        # the library don't support inserting text 
        title = "Cuenta de ahorros"
        title = title.center(title.length + 50)
        
        menu = basic_menu(title)

        menu.add('Consultar saldo') do |selected|
            balance = @account_controller.get_balance()
            @prompt.ok('Su saldo disponible es: ' + balance[:available].to_s)
            @prompt.ok('Su saldo total es: ' + balance[:total].to_s)
                        
            sleep(3)
            account_menu()
        end
        menu.add('Cargar cuenta') do |selected|
            transaction_param = ask_params("Valor")
            amount = transaction_param["Valor"].to_f
            @account_controller.debit(amount)
            @prompt.ok("Carga Exitosa!")
            
            sleep(1)
            account_menu()
        end
        menu.add('Descargar cuenta') do |selected|
            transaction_param = ask_params("Valor")
            amount = transaction_param["Valor"].to_f
            @account_controller.withdraw(amount)
            @prompt.ok("Descarga Exitosa!")
            
            sleep(1)
            account_menu()
        end
        menu.add('Consignar a otra cuenta') do |selected|
            transaction_param = ask_params("Valor", "ID de la cuenta")
            amount = transaction_param["Valor"].to_f
            final_account_id = transaction_param["ID de la cuenta"].to_i
            @account_controller.consign_to_another_account(amount, final_account_id)
            @prompt.ok("Transacción Exitosa!")
            
            sleep(1)
            account_menu()
        end
        menu.add('Regresar') do |selected|
            LoggedView.new()
        end
        
        menu.show
    end
end