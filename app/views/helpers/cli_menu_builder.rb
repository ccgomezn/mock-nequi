require 'terminal-menu'

module CliMenuBuilder
  def basic_menu(title, description = '')
    menu = TerminalMenu.new(title: title,
                            description: description.center(description.length + 2),
                            width: 70,
                            fg: '#9F01FF',
                            bg: '#21054C')
  end
end
