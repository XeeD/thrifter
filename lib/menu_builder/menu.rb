module MenuBuilder
  class Menu < Node
    def initialize(name, &block)
      super(nil, name, &block)
      MenuBuilder.add_menu(self)
    end

    def group(name, options={}, &block)
      add_child MenuGroup.new(self, name, options, &block)
    end

    def groups
      children.each { |group| yield group }
    end
  end
end
