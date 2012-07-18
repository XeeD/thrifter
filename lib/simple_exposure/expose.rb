require "simple_exposure/exposure"

module SimpleExposure
  module Expose
    def expose(name, options={}, &block)
      exposure = Exposure.new(name, &block)
      define_method(name) do
        Brand.find(params[:id])
      end
      helper_method name
      hide_action name
    end
  end
end