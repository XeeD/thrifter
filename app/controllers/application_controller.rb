class ApplicationController < ActionController::Base
  protect_from_forgery

  layout :set_layout_template

  private

  def set_layout_template
    if request.headers['X-PJAX']
      "pjax"
    else
      "application"
    end
  end
end