module MenuBuilder
  class TabGroup
    cattr_accessor :tab_groups
    self.tab_groups = {}

    def initialize(name)
      @tabs = []
    end

    def add_tab(name)
      @tabs << name
    end

    def self.[](name)
      tab_groups[name] ||= new(name)
      tab_groups[name]
    end
  end
end
