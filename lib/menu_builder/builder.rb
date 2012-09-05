class MenuBuilder::Builder
  include Rails.application.routes.url_helpers

  def self.build(&builder_block)
    builder = new
    builder.instance_eval(&builder_block)
  end

  def menu(name, &block)
    MenuBuilder::Menu.new(name, &block)
  end
end
