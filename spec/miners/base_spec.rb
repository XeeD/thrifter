require "spec_helper"

module Miners
  EXAMPLE_XML = File.join(Rails.root, "spec/fixtures/import/example.xml")

  class ExampleMiner < Base
    def each
      records.each do |record_xml|
        yield Record.new(record_xml)
      end
    end

    def records
      @xml.xpath("/products/product")
    end

    def load_resource
      @xml = parse_xml(EXAMPLE_XML)
    end

    class Record < Base::XMLRecord
      def recycling_fee=(value)
        throw :original_method if value == :test
        self[:recycling_fee] = value
      end

      extract_xpaths do
        integer "number" => :id
        string "name" => :name
        money "price" => :purchase_price
        money "internet_price" => :internet_price
        integer "vat" => :vat
        money_plus_vat "phe" => :recycling_fee
      end
    end
  end

  describe ExampleMiner do
    let(:example_instance) { ExampleMiner.new }

    context "class methods" do
      let(:base_class) { Base }

      describe ".upload_path" do
        it "returns appends filename to [Rails.root]/tmp/import/uploads" do
          base_class.upload_path("example.xml").should =~ /tmp\/import\/uploads\/example\.xml$/
        end
      end
    end

    describe "#parse_xml" do
      it "returns instance of Nokogiri::XML::Document" do
        example_instance.send(:parse_xml, EXAMPLE_XML).should be_an_instance_of(Nokogiri::XML::Document)
      end
    end

    describe "#mine_data" do
      it "calls each on subclass" do
        example_instance.should_receive(:each)
        example_instance.mine_data
      end
    end

    describe "#initialize" do
      it "loads the resource using #load_resource" do
        ExampleMiner.any_instance.should_receive(:load_resource)
        ExampleMiner.new
      end
    end

    describe ExampleMiner::Record do
      let(:record_xml) { example_instance.records.first }
      let(:record_instance) { ExampleMiner::Record.new(record_xml) }

      context "class methods" do
        describe ".extract_xpaths" do
          it "defines default attrbiute writers" do
            record_instance.public_methods(false).should =~
                [:id=, :name=, :purchase_price=, :recycling_fee=, :internet_price=, :vat=]

          end

          it "doesn't redefine already defined attribute writers" do
            expect {
              record_instance.recycling_fee = :test
            }.to throw_symbol(:original_method)
          end

          example "#string inside block extracts striped string" do
            record_instance[:name].should == "Product 1"
          end

          example "#integer inside block extracts integer" do
            record_instance[:id].should == 123
          end

          example "#money inside block extracts rounded integer (when value is being ceiled)" do
            record_instance[:purchase_price].should == 12568
          end

          example "#money inside block extracts rounded integer (when value is being floored)" do
            record_instance[:internet_price].should == 9564
          end

          example "#money_plus_vat uses extracted VAT value to compute price with VAT" do
            record_instance[:recycling_fee].should == 66
          end
        end

        describe ".add_extractor" do
          it "saves block and executes it when the object is initialized" do
            extractor_block = ->(record_xml) { throw :called }
            ExampleMiner::Record.class_eval do
              register_extractor(&extractor_block)
            end
            expect {
              ExampleMiner::Record.new(record_xml)
            }.to throw_symbol(:called)
          end
        end
      end

      it "saves data using Hash-like acessor" do
        record_instance[:test_value] = :testing
        record_instance[:test_value].should == :testing
      end
    end
  end
end