require_relative 'helpers/cli_menu_builder'
require_relative 'helpers/cli_input'
require_relative 'logged_view'
require_relative 'principal_goal_view'
require_relative 'goal_transaction_view'
require_relative 'ended_goal_view'
require 'tty-prompt'

class ListGoalView
    include CliInput
    include CliMenuBuilder

    def initialize(account_controller, goal_controller)
        @account_controller = account_controller
        @goal_controller = goal_controller

        list_goal_menu()
    end
    
    private
    def list_goal_menu()
        # this is for filling the layout in the description
        # the library don't support inserting text 
        title = "Mis Metas"
        title = title.center(title.length + 55)

        menu = basic_menu(title)
        
        goals = @goal_controller.find_all()
        goals.each do |goal|
            name = goal[1]
            goal_id = goal[0]
            deadline = goal[5]
            balance = @goal_controller.get_balance(goal_id)
            space = " "

            menu.add(name + space*15 + "Saldo ahorrado: #{balance}") do
                date = DateTime.now
                date = date.strftime('%Y-%m-%d %H:%M:%S')
                if date <= deadline
                    GoalTransactionView.new(@account_controller,
                                            @goal_controller, 
                                            goal)
                else
                    EndedGoalView.new(@account_controller,
                                      @goal_controller, 
                                      goal)
                end
                
                
            end
        end
        menu.add('Regresar') do
            PrincipalGoalView.new(@account_controller, @goal_controller)
        end

        menu.show
    end
end