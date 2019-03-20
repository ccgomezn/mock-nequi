require_relative 'helpers/cli_menu_builder'
require_relative 'helpers/cli_input'
require_relative 'logged_view'
require_relative 'list_goal_view'
require 'tty-prompt'

class PrincipalGoalView
    include CliInput
    include CliMenuBuilder

    def initialize(account_controller, goal_controller)
        @account_controller = account_controller
        @goal_controller = goal_controller
        @prompt = TTY::Prompt.new(help_color: :cyan, active_color: :bright_magenta)

        principal_goal_menu()
    end
    
    private
    def principal_goal_menu()
        # this is for filling the layout in the description
        # the library don't support inserting text 
        title = "Metas"
        title = title.center(title.length + 63)

        menu = basic_menu(title)
        
        menu.add('Crear Meta') do
            name = ask_valid_string("Name")
            goal = ask_valid_money("Monto total de la meta")
            date = ask_valid_date("Fecha máxima (YYYY-mm-dd)")
            datetime = date += " 00:00:00"
            
            if @goal_controller.create(name, goal, datetime)
                @prompt.ok("Creacion exitosa")
                sleep(1)
            else
                @prompt.error("Creacion fallida")
                sleep(1)
            end
            
            principal_goal_menu()
        end
        menu.add('Mis metas') do
            ListGoalView.new(@account_controller, @goal_controller)        
        end
        menu.add('Regresar') do
            LoggedView.new()
        end

        menu.show
    end
end