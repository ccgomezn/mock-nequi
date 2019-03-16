require_relative '../modules/cli_menu_builder'
require_relative 'logged_view'
require 'tty-prompt'

class PocketView
    include CliMenuBuilder

    def initialize(pocket_controller)
        @pocket_controller = pocket_controller
        pocket_menu()
    end
    
    def pocket_menu()
        # this is for filling the layout in the description
        # the library don't support inserting text 
        title = "Bolsillos"
        title = title.center(title.length + 60)

        menu = basic_menu(title)
        
        menu.add('Crear bolsillo') do |selected|
            p selected
        end
        menu.add('Cargar bolsillo') do |selected|
            p selected
        end
        menu.add('Descargar bolsillo') do |selected|
            p selected
        end
        menu.add('Eliminar bolsillo') do |selected|
            p selected
        end
        menu.add('Regresar') do |selected|
            LoggedView.new()
        end
        menu.show
    end
end