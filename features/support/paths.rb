# encoding: UTF-8

def get_section_url(section)
  case section
    when "administrace produktů" then "/admin/produkty/"
    when "administrace značek"   then "/admin/znacky/"
      #admin_products_path
    else raise "section url for '#{section}' was not found"
  end
end

def get_form_url(form)
  case form
    when "přidání nové značky" then "/admin/new"
    else raise "form url for '#{form}' was not found"
  end
end