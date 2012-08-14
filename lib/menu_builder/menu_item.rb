module MenuBuilder
  class MenuItem < Node
    def tab(name)
      TabGroup[prefix.to_sym].add_tab(name)
    end

    undef_method :children

    def title
      options[:title]
    end

    include Rails.application.routes.url_helpers

    def url
      options[:url] || send(guess_named_route)
    end

    def guess_named_route
      (prefix + "_path").to_sym
    end
  end
end
