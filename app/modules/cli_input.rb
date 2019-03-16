module CliInput

    def ask_param(param)
        @prompt.ask("#{param}: ", required: true)
    end

    def mask_param(param)
        @prompt.mask("#{param}: ", required: true)
    end

    def ask_params(*params)
        filled_params = {}
        params.each do |param|
            if param.include? ("Password")
                filled_params[param] = mask_param(param)
            else
                filled_params[param] = ask_param(param)
            end
        end

        return filled_params
    end
end