require_relative '../modules/cli_menu_builder'
require_relative 'logged_view'
require 'tty-prompt'

class MattressView
    include CliMenuBuilder

    def initialize(mattress_controller)
        @mattress_controller = mattress_controller
        mattress_menu()
    end
    
    def mattress_menu()
        # this is for filling the layout in the description
        # the library don't support inserting text 
        title = "Colchon"
        title = title.center(title.length + 63)

        menu = basic_menu(title)

        menu.add('Cargar colchon') do |selected|
            p selected
        end
        menu.add('Descargar colchon') do |selected|
            p selected
        end
        menu.add('Regresar') do |selected|
            LoggedView.new()
        end
        
        menu.show
    end
end