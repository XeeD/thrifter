class ApplicationController < ActionController::Base
  protect_from_forgery

  layout :set_layout_template

  def set_pjax_data(id, data)
    pjax_data[id.to_sym] = data
  end

  def pjax_data
    @pjax_data ||= {}
  end

  private

  def set_layout_template
    if request.headers['X-PJAX']
      "pjax"
    else
      "application"
    end
  end
end