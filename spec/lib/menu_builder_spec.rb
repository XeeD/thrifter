require "spec_helper"
require "menu_builder"

module MenuBuilder
  describe "#menu" do
    def build(&block)
      MenuBuilder::Builder.build(&block)
    end

    it "returns menu with given name created by builder if it exists" do
      build do
        menu(:admin)
      end
      MenuBuilder.menu_with_name(:admin).name.should == :admin
    end
  end

  describe Builder do
    def build(&block)
      MenuBuilder::Builder.build(&block)
    end

    let(:builder) { MenuBuilder.new("spec/fixtures/builder/empty.rb") }

    context "#build" do
      it "runs the block in instance context" do
        #MenuBuilder::Builder.any_instance.should_receive(:menu)

        build do
          menu :admin
        end
      end

      it "has named routes methods in scope" do
        generated_path = ""
        route = Rails.application.routes.named_routes.first[0].to_s + "_path"
        build do
          generated_path = send(route)
        end
        generated_path.should == Rails.application.routes.url_helpers.send(route)
      end

      describe "#menu" do
        it "creates new Menu instance" do
          Menu.should_receive(:new).with(:admin)

          build do
            menu :admin
          end
        end

        it "allows to build groups using #group method inside given block" do
          Menu.any_instance.should_receive(:group).with("Produkty")

          build do
            menu :admin do
              group "Produkty"
            end
          end
        end

        context "#group" do
          it "creates new MenuGroup" do
            MenuGroup.should_receive(:new).with(an_instance_of(Menu), "Produkty", an_instance_of(Hash))

            build do
              menu :admin do
                group "Produkty"
              end
            end
          end

          context "#item" do
            it "creates new MenuItem" do
              MenuItem.should_receive(:new).with(an_instance_of(MenuGroup), :products, an_instance_of(Hash))

              build do
                menu :admin do
                  group "Produkty" do
                    item :products, title: "Produkty"
                  end
                end
              end
            end

            context "#tab" do
              it "creates new TabGroup with given name when called first" do
                tab_group_double = double("tab group").as_null_object
                TabGroup.tab_groups = {}
                TabGroup.should_receive(:new).with(:admin_products).and_return(tab_group_double)

                build do
                  menu :admin do
                    group "Produkty" do
                      item :products, title: "Produkty" do
                        tab :photos
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end

    let(:menu) { menu = Menu.new(:admin) {} }

    describe Menu do
      describe "#name" do
        it "returns the name that it was initialized with" do
          menu.name.should == :admin
        end
      end

      describe "#prefix" do
        it "returns prefixes given argument with it's [own_name]_" do
          menu.prefix_name(:products).should == "admin_products"
        end
      end

      context do
        let(:menu_group_1) { double("menu group 1") }
        let(:menu_group_2) { double("menu group 2") }

        describe "#children" do
          it "returns all MenuGroup instances created by Menu#group" do
            MenuGroup.stub(new: menu_group_1)
            menu.group("Produkty")

            menu.children.should include(menu_group_1)
          end
        end

        describe "#groups" do
          it "yields each child" do
            MenuGroup.stub(:new).and_return(menu_group_1, menu_group_2)
            menu.group("Produkty")
            menu.group("Parametry")

            expect { |b|
              menu.groups(&b)
            }.to yield_successive_args(menu_group_1, menu_group_2)
          end
        end
      end
    end

    describe MenuGroup do
      def new_menu_group(options = {})
        options.reverse_merge!(prefix: "product")
        MenuGroup.new(menu, "Produkty", options) {}
      end

      let(:menu_group) { new_menu_group }

      describe "#name" do
        it "returns the name that it was initialized with" do
          new_menu_group.name.should == "Produkty"
        end
      end

      describe "#prefix_name" do
        it "returns prefixes argument with it's parent prefix and [own_prefix]_" do
          new_menu_group.prefix_name("url").should == "admin_product_url"
        end

        it "returns only name prefixed only with parent prefix when it has no prefix in options" do
          new_menu_group(prefix: nil).prefix_name("products").should == "admin_products"
        end
      end

      context do
        let(:menu_item_1) { double("menu group 1") }
        let(:menu_item_2) { double("menu group 2") }

        describe "#children" do
          it "returns all MenuItem instances created by Menu#group" do
            MenuItem.stub(new: menu_item_1)
            menu_group.item("Produkty")

            menu_group.children.should include(menu_item_1)
          end
        end

        describe "#items" do
          it "yields each child" do
            MenuItem.stub(:new).and_return(menu_item_1, menu_item_2)
            menu_group.item("Produkty")
            menu_group.item("Parametry")

            expect { |b|
              menu_group.items(&b)
            }.to yield_successive_args(menu_item_1, menu_item_2)
          end
        end
      end
    end

    describe MenuItem do
      it "is the leaf node (has no children)" do
        menu_item = MenuItem.new(nil, nil)
        menu_item.should_not respond_to(:children)
      end

      def menu_item_with_options(options)
        MenuItem.new(nil, :test, options)
      end

      context "option getters" do

        it "#title returns options[:title]" do
          menu_item_with_options(title: "Foo").title.should == "Foo"
        end
      end

      describe "#url" do
        context "url defined in options" do
          it "returns value from options" do
            menu_item_with_options(url: "/product").url.should == "/product"
          end
        end

        context "without url" do
          it "guesses named route from it's name and parent's prefix" do
            menu = Menu.new(:admin)
            group = menu.group("Produkty", prefix: :product)
            item = group.item(:photos)
            item.stub(admin_product_photos_path: "/foobar")
            item.url.should == "/foobar"
          end
        end
      end
    end

    after(:all) do
      #rspec_reset
      MenuBuilder.menus = {}
    end
  end
end