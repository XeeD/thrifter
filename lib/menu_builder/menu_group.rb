module MenuBuilder
  class MenuGroup < Node
    def item(name, options={}, &block)
      add_child MenuItem.new(self, name, options, &block)
    end

    def own_prefix
      options[:prefix]
    end

    def items
      children.each { |item| yield item }
    end
  end
end
