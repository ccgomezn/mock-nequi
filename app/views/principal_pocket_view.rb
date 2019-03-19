require_relative 'helpers/cli_menu_builder'
require_relative 'helpers/cli_input'
require_relative 'logged_view'
require_relative 'list_pocket_view'
require 'tty-prompt'

class PrincipalPocketView
    include CliInput
    include CliMenuBuilder

    def initialize(pocket_controller)
        @pocket_controller = pocket_controller
        @prompt = TTY::Prompt.new(help_color: :cyan, active_color: :bright_magenta)

        principal_pocket_menu()
    end
    
    private
    def principal_pocket_menu()
        # this is for filling the layout in the description
        # the library don't support inserting text 
        title = "Bolsillos"
        title = title.center(title.length + 60)

        menu = basic_menu(title)
        
        menu.add('Crear bolsillo') do
            name = ask_valid_string("Name")
            
            if @pocket_controller.create(name)
                @prompt.ok("Creacion exitosa")
                sleep(1)
            else
                @prompt.error("Creacion fallida")
                sleep(1)
            end
            
            principal_pocket_menu()
        end
        menu.add('Mis bolsillos') do
            ListPocketView.new(@pocket_controller)        
        end
        menu.add('Regresar') do
            LoggedView.new()
        end

        menu.show
    end
end