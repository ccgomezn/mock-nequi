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
    
    def transaction_view()
        # this is for filling the layout in the description
        # the library don't support inserting text 
        data = @transaction_controller.get_all_transactions()
        if !data[:individual_transactions].nil?
            data[:individual_transactions].each do |transaction|
                @prompt.say('Transaccion entre productos: ', color: :blue)
                amount = ''
                date = ''
                data[:transactions].each do |real_transaction|
                    if(transaction[4] == real_transaction[0])
                        amount = real_transaction[2]
                        date = real_transaction[1]
                                            break

                    end
                end
                @prompt.say('Producto: ' + transaction[1].to_s, color: :bright_magenta)
                @prompt.say('Id de producto: ' + transaction[2].to_s, color: :bright_magenta)
                @prompt.say('Valor: ' + amount.to_s, color: :bright_magenta)
                @prompt.say('Fecha:  ' + date.to_s, color: :bright_magenta)
                @prompt.say('')
                @prompt.say('')
            end
        end
        if !data[:mutual_transactions_out].nil?
            data[:mutual_transactions_out].each do |transaction|
                @prompt.say('Consignacion a otras cuentas: ', color: :blue)
                amount = ''
                date = ''
                data[:transactions].each do |real_transaction|
                    if(transaction[3] == real_transaction[0])
                        amount = real_transaction[2]
                        date = real_transaction[1]
                                            break

                    end
                end
                @prompt.say('Cuenta de destino: ' + transaction[3].to_s, color: :bright_magenta)
                @prompt.say('Valor: ' + amount.to_s, color: :bright_magenta)
                @prompt.say('Fecha:  ' + date.to_s, color: :bright_magenta)
                @prompt.say('')
                @prompt.say('')
            end
        end
        if !data[:mutual_transactions_in].nil?
            data[:mutual_transactions_in].each do |transaction|
                @prompt.say('Consignacion de otra cuentas: ', color: :blue)
                amount = ''
                date = ''
                data[:transactions].each do |real_transaction|
                    if(transaction[3] == real_transaction[0])
                        amount = real_transaction[2]
                        date = real_transaction[1]
                        break
                    end
                end
                @prompt.say('Cuenta de origen: ' + transaction[2].to_s, color: :bright_magenta)
                @prompt.say('Valor: ' + amount.to_s, color: :bright_magenta)
                @prompt.say('Fecha:  ' + date.to_s, color: :bright_magenta)
                @prompt.say('')
                @prompt.say('')
            end
        end
        @prompt.keypress('Presione una tecla para continuar')

        LoggedView.new()
    end
end