module SimpleExposure
  class Exposure
    attr_reader :name, :block

    def initialize(name, &block)
      @name = name
      @block = block
    end

    def exposure_with_block?
      !@block.nil?
    end
  end
end