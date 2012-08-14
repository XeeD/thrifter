require "spec_helper"

module Admin
  module AdminHelper
    describe "#menu" do
      before do
        MenuBuilder.menus = {}
      end

      it "finds menu with given name" do
        MenuBuilder.should_receive(:menu_with_name).with(:admin)
        helper.menu :admin
      end

      it "yields to block when it finds the menu" do
        menu = double("menu")
        MenuBuilder.should_receive(:menu_with_name).with(:admin).and_return(menu)

        expect { |b|
          helper.menu :admin, &b
        }.to yield_with_args(menu)
      end

      after do
        MenuBuilder.menus = {}
      end
    end
  end
end