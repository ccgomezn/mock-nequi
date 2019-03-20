require_relative 'helpers/cli_menu_builder'
require_relative 'logged_view'
require 'tty-prompt'

class TransactionView
    include CliMenuBuilder

    def initialize(transaction_controller)
        @transaction_controller = transaction_controller
        @prompt = TTY::Prompt.new(help_color: :cyan, active_color: :bright_magenta)
        transaction_view()
    end
    

    def show_individual_transaction(transaction)
        @prompt.say('--------------------------------------', color: :bright_magenta)
        @prompt.say('Producto: ' + transaction[1].to_s, color: :bright_magenta)
        @prompt.say('Id de producto: ' + transaction[2].to_s, color: :bright_magenta)
        @prompt.say('Locación: ' + transaction[3].to_s, color: :bright_magenta)
        @prompt.say('Valor: ' + transaction[8].to_s, color: :bright_magenta)
        @prompt.say('Fecha:  ' + transaction[7].to_s, color: :bright_magenta)
        @prompt.say('')
        @prompt.say('')
    end

    def show_consignation_to_another_account(transaction)
        @prompt.say('--------------------------------------', color: :bright_magenta)
        @prompt.say('Cuenta de destino: ' + transaction[5].to_s, color: :bright_magenta)
        @prompt.say('Valor: ' + transaction[8].to_s, color: :bright_magenta)
        @prompt.say('Fecha:  ' + transaction[7].to_s, color: :bright_magenta)
        @prompt.say('Producto de origen:  ' + transaction[4].to_s, color: :bright_magenta)
        @prompt.say('Id producto de origen:  ' + transaction[3].to_s, color: :bright_magenta)
        @prompt.say('')
        @prompt.say('')
    end

    def show_consignation_from_another_account(transaction)
        @prompt.say('--------------------------------------', color: :bright_magenta)
        @prompt.say('Cuenta de origen: ' + transaction[2].to_s, color: :bright_magenta)
        @prompt.say('Valor: ' + transaction[8].to_s, color: :bright_magenta)
        @prompt.say('Fecha:  ' + transaction[7].to_s, color: :bright_magenta)
        @prompt.say('')
        @prompt.say('')
    end

    def transaction_view()
        # this is for filling the layout in the description
        # the library don't support inserting text 
        data = @transaction_controller.get_all_transactions()
        unless data[:individual_transactions].length.zero?
            @prompt.say('Transaccion entre productos: ', color: :blue)
            data[:individual_transactions].each do |transaction|
                show_individual_transaction(transaction)
            end
        end
        unless data[:mutual_transactions_out].length.zero?
            @prompt.say('Consignacion a otras cuentas: ', color: :blue)
            data[:mutual_transactions_out].each do |transaction|
                show_consignation_to_another_account(transaction)
            end
        end
        unless data[:mutual_transactions_in].length.zero?

            @prompt.say('Consignacion de otra cuentas: ', color: :blue)
            data[:mutual_transactions_in].each do |transaction|
                show_consignation_from_another_account(transaction)
            end
        end
        @prompt.keypress('Presione una tecla para continuar')

        LoggedView.new()
    end
end