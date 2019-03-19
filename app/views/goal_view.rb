require_relative 'helpers/cli_menu_builder'
require_relative 'helpers/cli_input'

require_relative 'logged_view'
require 'tty-prompt'

class GoalView
    include CliMenuBuilder
    include CliInput

    def initialize(goal_controller)
        @goal_controller = goal_controller
        @prompt = TTY::Prompt.new(help_color: :cyan, active_color: :bright_magenta)
        goal_menu()
    end
    
    private
    def goal_menu()
        # this is for filling the layout in the description
        # the library don't support inserting text 
        title = "Metas"
        title = title.center(title.length + 65)

        menu = basic_menu(title)
        
        menu.add('Crear meta') do |selected|
            goal_param = ask_params("Nombre", "Valor", "Deadline (YYYY-mm-dd HH:mm:ss)")

            @goal_controller.insert(goal_param["Nombre"],
                                    goal_param["Valor"],
                                    goal_param["Deadline (YYYY-mm-dd HH:mm:ss)"])
               @prompt.ok('Meta creada')
               sleep(2) 
                                    goal_menu()

               
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