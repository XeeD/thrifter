require 'active_support/inflector'
require 'active_support/core_ext/string/inflections'
require 'active_support/core_ext/module/delegation'

module SimpleExposure
  class ActiveRecordHook
    delegate :exposure_with_block?, :to => :exposure
    attr_reader :controller, :exposure

    def initialize(exposure, controller)
      @controller = controller
      @exposure = exposure
    end

    def exposed_collection?
      exposure_name.to_s == exposure_name.to_s.pluralize
    end

    def exposure_name
      @exposure.name
    end

    def model
      exposure_name.to_s.classify.constantize
    end

    def find
      if exposure_with_block?
        eval_block_for_exposure
      elsif exposed_collection?
        find_plural
      else
        find_singular
      end
    end

    def find_singular
      if !param(id_for_exposure_name).nil?
        model.find(param(id_for_exposure_name))
      elsif !param(:id).nil?
        model.find(param(:id))
      else
        model.new
      end
    end

    def find_plural
      model.all
    end

    def eval_block_for_exposure
      @exposure.block.call
    end

    def id_for_exposure_name
      (exposure_name.to_s + "_id").to_sym
    end

    def param(param_name)
      controller.send(:params)[param_name]
    end
  end
end