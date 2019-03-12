require '../modules/cli_menu_builder'

class PrincipalMenu
    include CliMenuBuilder

    def initialize()
        @title = "Mock Nequi"
        @description = "Prototipo de sistema Bancario para transferir dinero entre personas"
        @menu = create_menu()
    end

    def create_menu()
        menu = basic_menu(@title, @description)
        
        menu.add('Crear usuario') do |selected|
            puts selected
        end
        menu.add('Entrar') do |selected|
            puts selected
        end
        menu.add('Ayuda') do |selected|
            puts selected
        end
        
        return menu
    end

    def show()
        @menu.show
    end
end