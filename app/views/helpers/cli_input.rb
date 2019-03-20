module CliInput

    def ask_param(param)
        @prompt.ask("#{param}: ", required: true)
    end

    def mask_param(param)
        @prompt.mask("Clave: ", required: true) 
    end

    def ask_valid_param(param, regex_validation)
        @prompt.ask("#{param}: ", required: true) do |q|
            q.validate(regex_validation, "Dato erróneo: #{param}")
        end
    end

    def ask_valid_email(param)
        ask_valid_param(param, :email)
    end

    def ask_valid_letter(param)
        letter_condition = /\A([A-Za-z ]+).{4,30}\Z/
        ask_valid_param(param, letter_condition)
    end

    def ask_valid_date(param)
        date_regex = /\A(\d{4}-([0]\d|[1][0-2])-([0-2]\d|[3][0-1]))\Z/
        ask_valid_param(param, date_regex)
    end

    def ask_valid_transaction(param, available_balance)
        transaction = @prompt.ask("#{param}: ", required: true) 
        if transaction.to_f <= 0
            @prompt.error("Monto inválido para la transacción")
            ask_valid_transaction(param, available_balance)
        elsif transaction.to_f > available_balance
            @prompt.error("Fondos insuficientes para la transacción")
            ask_valid_transaction(param, available_balance)
        else
            return transaction
        end
    end

    def ask_valid_money(param)
        debit = @prompt.ask("#{param}: ", required: true, convert: :float) 
        if debit.to_f <= 0
            @prompt.error("Monto inválido para asignar")
            ask_valid_money(param)
        else
            return debit
        end
    end

    def ask_transaction_email(param, actual_email)
        email = ask_valid_email(param)
        if email == actual_email
            @prompt.error("Email no puede ser igual al de tu cuenta!")
            ask_transaction_email(param, actual_email)
        else
            return email
        end
    end

    def ask_valid_string(param)
        letter_condition = /\A([A-Za-z0-9_ ]+).{4,15}\Z/
        ask_valid_param(param, letter_condition)
    end
    
    def mask_valid_password()
        len_condition = /\A.{4,}\Z/
        @prompt.mask("Clave: ", required: true) do |p|
            p.validate(len_condition, "Clave demasiado corta!")
        end
    end

    def ask_params(*params)
        filled_params = {}
        params.each do |param|
            if param.include? ("Clave")
                filled_params[param] = mask_param(param)
            else
                filled_params[param] = ask_param(param)
            end
        end

        return filled_params
    end
end