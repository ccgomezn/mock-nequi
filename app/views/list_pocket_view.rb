require_relative 'helpers/cli_menu_builder'
require_relative 'helpers/cli_input'
require_relative 'logged_view'
require_relative 'pocket_view'
require 'tty-prompt'

class ListPocketView
    include CliMenuBuilder

    def initialize(pocket_controller)
        @pocket_controller = pocket_controller
        @prompt = TTY::Prompt.new(help_color: :cyan, active_color: :bright_magenta)

        pocket_menu()
    end
    
    private
    def list_pocket_menu()
        # this is for filling the layout in the description
        # the library don't support inserting text 
        title = "Bolsillos"
        title = title.center(title.length + 60)

        menu = basic_menu(title)
        
        menu.add('Crear bolsillo') do |selected|
            p selected
        end
        menu.add('Mis bolsillos') do
            
        end
        menu.add('Regresar') do |selected|
            LoggedView.new()
        end

        menu.show
    end
end