require_relative '../modules/cli_menu_builder'
require_relative 'logged_view'
require 'tty-prompt'

class GoalView
    include CliMenuBuilder

    def initialize(goal_controller)
        @goal_controller = goal_controller
        goal_menu()
    end
    
    def goal_menu()
        # this is for filling the layout in the description
        # the library don't support inserting text 
        title = "Metas"
        title = title.center(title.length + 65)

        menu = basic_menu(title)
        
        menu.add('Crear meta') do |selected|
            p selected
        end
        menu.add('Cargar meta') do |selected|
            p selected
        end
        menu.add('Eliminar meta') do |selected|
            p selected
        end
        menu.add('Regresar') do |selected|
            LoggedView.new()
        end
       
        menu.show
    end
end