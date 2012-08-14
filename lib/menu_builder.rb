module MenuBuilder
  mattr_accessor :menus

  self.menus = {}

  def self.menu_with_name(name)
    load "#{name}_menu.rb" unless menus[name]
    menus[name]
  end

  def self.add_menu(menu)
    self.menus[menu.name] = menu
  end
end
