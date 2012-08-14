module MenuBuilder
  class Node
    attr_reader :name, :parent, :options, :children

    def initialize(parent, name, options={}, &block)
      @name = name
      @parent = parent
      @options = options
      @children = []
      instance_eval(&block) if block_given?
    end

    def add_child(child)
      children << child
      child
    end

    def prefixes
      parent_prefixes.push(own_prefix)
    end

    def own_prefix
      options[:prefix] || name.to_s
    end

    def parent_prefixes
      if parent.respond_to?(:prefixes)
        parent.prefixes
      else
        []
      end
    end

    def prefix
      prefixes.compact.join("_")
    end

    def prefix_name(name)
      if prefix.blank?
        name
      else
        "#{prefix}_#{name}"
      end
    end
  end
end
