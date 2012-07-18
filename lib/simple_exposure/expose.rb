require "simple_exposure/exposure"
require "simple_exposure/active_record_hook"

module SimpleExposure
  module Expose
    def expose(name, &block)
      exposure = Exposure.new(name, block)
      active_record_hook = ActiveRecordHook.new(exposure)
      define_method(name) do
        active_record_hook.find(params)
      end
      helper_method name
      hide_action name
    end
  end
end