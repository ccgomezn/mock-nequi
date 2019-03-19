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
        letter_condition = /\A([A-Za-z ]+)\Z/
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