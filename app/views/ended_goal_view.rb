require_relative 'helpers/cli_menu_builder'
require_relative 'helpers/cli_input'
require_relative 'list_goal_view'
require 'tty-prompt'

class EndedGoalView
    include CliInput
    include CliMenuBuilder

    def initialize(account_controller, goal_controller, goal)
        @account_controller = account_controller
        @goal_controller = goal_controller
        @goal = goal
        @prompt = TTY::Prompt.new(help_color: :cyan, active_color: :bright_magenta)

        goal_end_menu()
    end
    
    private
    def goal_end_menu()
        # this is for filling the layout in the description
        # the library don't support inserting text 
        goal_name = @goal[1]
        goal_id = @goal[0]
        deadline = @goal[5]
        goal_name_center = goal_name.center(goal_name.length + 57)
        description = "La fecha para cumplir la meta ha terminado #{deadline}"
        description = description.center(description.length + 5)
        menu = basic_menu(goal_name_center, description)
        
        menu.add('Informacion completa') do
            total_amount = @goal[2]
            balance = @goal[3]
            amount_to_goal = total_amount - balance
            state = @goal[4]
            deadline = @goal[5]

            @prompt.say("Nombre Meta: #{goal_name}", color: :blue)
            @prompt.say("Monto total de meta: #{total_amount}", 
                        color: :red)
            @prompt.say("Dinero ahorrado: #{balance}", 
                        color: :red)
            @prompt.say("Dinero faltante para cumplir meta: #{amount_to_goal}", 
                        color: :red)
            @prompt.say("Estado actual: #{state}", color: :red)
            @prompt.say("Fecha límite: #{deadline}", color: :red)
            
            @prompt.keypress('Presione una tecla para continuar')
            goal_end_menu()
        end
        menu.add('Cerrar meta') do
            delete_choices = %w(Si No)
            choice = @prompt.select("Estas seguro de eliminar #{goal_name}?",
                                    delete_choices, help: "")
            
            if choice == "Si"
                @goal_controller.delete(goal_id)
                @prompt.ok("Tu meta '#{goal_name}' ha sido cerrada")
            end

            sleep(1)
            ListGoalView.new(@account_controller, @goal_controller)
        end
        menu.add('Regresar') do
            ListGoalView.new(@account_controller, @goal_controller)
        end
        
        menu.show
    end
end