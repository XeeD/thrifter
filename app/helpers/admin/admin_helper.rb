module Admin
  module AdminHelper
    def menu(name)
      menu = MenuBuilder.menu_with_name(name)
      yield menu if menu
    end
  end
end