# encoding: UTF-8
require "webrat"

Webrat.configure do |config|
  config.mode = :rails
end

module UrlHelper
  def get_section_url(section)
    case section
      when "administrace produktů" then "/admin/produkty/"
      when "administrace značek"   then "/admin/znacky/"
      else raise "section url not found"
    end
  end

  def get_form_url(form)
    case form
      when ""
      else raise "form url not found"
    end
  end
end

World do
  UrlHelper
end