require_relative 'helpers/cli_menu_builder'
require_relative 'helpers/cli_input'
require_relative 'logged_view'
require_relative 'principal_pocket_view'
require_relative 'pocket_transaction_view'
require 'tty-prompt'

class ListPocketView
  include CliInput
  include CliMenuBuilder

  def initialize(account_controller, pocket_controller)
    @account_controller = account_controller
    @pocket_controller = pocket_controller

    list_pocket_menu
  end

  private

  def list_pocket_menu
    # this is for filling the layout in the description
    # the library don't support inserting text
    title = 'Mis Bolsillos'
    title = title.center(title.length + 55)

    menu = basic_menu(title)

    pockets = @pocket_controller.find_all
    pockets.each do |pocket|
      name = pocket[1]
      pocket_id = pocket[0]
      balance = @pocket_controller.get_balance(pocket_id)
      space = ' '

      menu.add(name + space * 15 + "Saldo actual: #{balance}") do
        PocketTransactionView.new(@account_controller,
                                  @pocket_controller,
                                  pocket)
      end
    end
    menu.add('Regresar') do
      PrincipalPocketView.new(@account_controller, @pocket_controller)
    end

    menu.show
  end
end
