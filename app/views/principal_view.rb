require_relative 'helpers/cli_menu_builder'
require_relative 'helpers/cli_input'
require_relative 'logged_view'
require 'tty-prompt'
require_relative '../controllers/user_controller'

class PrincipalView
    include CliInput
    include CliMenuBuilder

    def initialize()
        @prompt = TTY::Prompt.new(help_color: :cyan, active_color: :bright_magenta)
        @user_controller = UserController.new()
        principal_menu()
    end

    def principal_menu()
        title = "Mock Nequi"
        description = "Prototipo de sistema Bancario para transferir dinero entre personas"
        title = title.center(title.length + 58)
        
        menu = basic_menu(title, description)
        
        menu.add('Crear usuario') do 
            email = ask_valid_email("Email")
            name = ask_valid_letter("Nombre")

            if @user_controller.create(name, email, mask_valid_password())
                @prompt.ok("Creacion de usuario exitosa!")
                sleep(1)
            else
                @prompt.error("Creacion de usuario fallida :c")
                sleep(1)
            end
            
            PrincipalView.new()
        end
        menu.add('Entrar') do |selected|
            login_data = ask_params("Email", "Clave")
            if @user_controller.login(login_data["Email"],
                                      login_data["Clave"])
                @prompt.ok("Bienvenido")
                sleep(1)

                LoggedView.new()
            else
                @prompt.error("Credenciales invalidas")
            
                sleep(1)
                PrincipalView.new()
            end
        end
        
        menu.show
    end
end