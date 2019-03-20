require_relative 'helpers/cli_menu_builder'
require_relative 'helpers/cli_input'
require_relative 'list_pocket_view'
require 'tty-prompt'

class PocketTransactionView
    include CliInput
    include CliMenuBuilder

    def initialize(account_controller, pocket_controller, pocket)
        @account_controller = account_controller
        @pocket_controller = pocket_controller
        @pocket = pocket
        @prompt = TTY::Prompt.new(help_color: :cyan, active_color: :bright_magenta)

        pocket_transaction_menu()
    end
    
    private
    def pocket_transaction_menu()
        # this is for filling the layout in the description
        # the library don't support inserting text 
        pocket_name = @pocket[1]
        pocket_id = @pocket[0]
        pocket_name_center = pocket_name.center(pocket_name.length + 57)

        menu = basic_menu(pocket_name_center)
        
        menu.add('Cargar bolsillo') do
            acc_balance = @account_controller.get_balance()
            available_acc_balance = acc_balance[:available]
            transaction_param = ask_valid_transaction("Valor",
                                                      available_acc_balance)
            amount = transaction_param.to_f
            @pocket_controller.debit(amount, pocket_id)
            @prompt.ok("Carga Exitosa!")
            
            sleep(1)
            pocket_transaction_menu()
        end
        menu.add('Descargar bolsillo') do
            pk_balance = @pocket_controller.get_balance(pocket_id)
            transaction_param = ask_valid_transaction("Valor", pk_balance)
            amount = transaction_param.to_f
            @pocket_controller.withdraw(amount, pocket_id)
            @prompt.ok("Descarga Exitosa!")
            
            sleep(1)
            pocket_transaction_menu()
        end
        menu.add('Consignar a otro usuario') do 
            balance = @pocket_controller.get_balance(pocket_id)
            amount_param = ask_valid_transaction("Valor", balance)
            
            origin_account_email = $session[:email]
            email_param = ask_transaction_email("Email del usuario",
                                                origin_account_email)
            amount = amount_param.to_f
            @pocket_controller.consign_to_another_account(amount, pocket_id,
                                                          email_param)
            @prompt.ok("Transacción Exitosa!")
            
            sleep(1)
            pocket_transaction_menu()
        end
        menu.add('Eliminar bolsillo') do
            delete_choices = %w(Si No)
            choice = @prompt.select("Estas seguro de eliminar #{pocket_name}?",
                                    delete_choices, help: "")
            
            if choice == "Si"
                @pocket_controller.delete(pocket_id)
                @prompt.ok("Tu bolsillo '#{pocket_name}' ha sido eliminado")
            end

            sleep(1)
            ListPocketView.new(@account_controller, @pocket_controller)
        end
        menu.add('Regresar') do
            ListPocketView.new(@account_controller, @pocket_controller)
        end
        
        menu.show
    end
end