require "spec_helper"

module Miners
  class ExampleMiner < Base

  end

  describe ExampleMiner do
    context "#initialize" do
      it "loads the resource using #load_resource" do
        ExampleMiner.any_instance.should_receive(:load_resource)
        ExampleMiner.new
      end
    end
  end
end