require_relative '../modules/cli_menu_builder'
require_relative '../modules/cli_input'
require_relative 'logged_view'
require 'tty-prompt'

class PrincipalView
    include CliInput
    include CliMenuBuilder

    def initialize()
        @prompt = TTY::Prompt.new(help_color: :cyan, active_color: :bright_magenta)
        principal_menu()
    end

    def principal_menu()
        title = "Mock Nequi"
        description = "Prototipo de sistema Bancario para transferir dinero entre personas"
        title = title.center(title.length + 58)
        
        menu = basic_menu(title, description)
        
        menu.add('Crear usuario') do 
            signup_data = ask_params("Name", "Email", "Password")
            LoggedView.new()
        end
        menu.add('Entrar') do |selected|
            login_data = ask_params("Email", "Password")
            LoggedView.new()
        end
        
        menu.show
    end
end