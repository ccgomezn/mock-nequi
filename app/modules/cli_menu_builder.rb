require 'terminal-menu'

module CliMenuBuilder
    
    def basic_menu(title, description)
        menu = TerminalMenu.new(title: title.center(title.length + 57),
            description: description.center(description.length + 2),
            width: 70,
            fg: '#9F01FF',
            bg: '#21054C') do |selected|
                puts "you have selected: #{selected}"
                menu.quit
            end
    end
end