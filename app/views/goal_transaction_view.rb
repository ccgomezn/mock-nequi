require_relative 'helpers/cli_menu_builder'
require_relative 'helpers/cli_input'
require_relative 'list_goal_view'
require 'tty-prompt'

class GoalTransactionView
  include CliInput
  include CliMenuBuilder

  def initialize(account_controller, goal_controller, goal)
    @account_controller = account_controller
    @goal_controller = goal_controller
    @goal = goal
    @prompt = TTY::Prompt.new(help_color: :cyan, active_color: :bright_magenta)

    goal_transaction_menu
  end

  private

  def goal_transaction_menu
    # this is for filling the layout in the description
    # the library don't support inserting text
    goal_id = @goal[0]
    goal_name = @goal[1]
    total_amount = @goal[2]
    balance = @goal[3]
    amount_to_goal = total_amount - balance
    state = @goal[4]
    deadline = @goal[5]
    goal_name_center = goal_name.center(goal_name.length + 57)

    menu = basic_menu(goal_name_center)

    menu.add('Informacion completa') do
      @prompt.say("Nombre Meta: #{goal_name}", color: :blue)
      @prompt.say("Monto total de meta: #{total_amount}",
                  color: :bright_magenta)
      @prompt.say("Dinero ahorrado: #{balance}",
                  color: :bright_magenta)
      @prompt.say("Dinero faltante para cumplir meta: #{amount_to_goal}",
                  color: :bright_magenta)
      @prompt.say("Estado actual: #{state}", color: :bright_magenta)
      @prompt.say("Fecha límite: #{deadline}", color: :bright_magenta)

      @prompt.keypress('Presione una tecla para continuar')
      goal_transaction_menu
    end
    menu.add('Cargar meta') do
      acc_balance = @account_controller.get_balance
      available_acc_balance = acc_balance[:available]
      transaction_param = ask_valid_transaction('Valor',
                                                available_acc_balance)
      amount = transaction_param.to_f
      @goal_controller.debit(amount, goal_id)
      @prompt.ok('Carga Exitosa!')

      sleep(1)
      goal_transaction_menu
    end
    menu.add('Descargar meta') do
      pk_balance = @goal_controller.get_balance(goal_id)
      transaction_param = ask_valid_transaction('Valor', pk_balance)
      amount = transaction_param.to_f
      @goal_controller.withdraw(amount, goal_id)
      @prompt.ok('Descarga Exitosa!')

      sleep(1)
      goal_transaction_menu
    end
    menu.add('Cerrar meta') do
      delete_choices = %w[Si No]
      choice = @prompt.select("Estas seguro de eliminar #{goal_name}?",
                              delete_choices, help: '')

      if choice == 'Si'
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
