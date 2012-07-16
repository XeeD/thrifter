# encoding: UTF-8

def get_section_url(section)
  case section
    when "administrace produktů" then "/admin/produkty/"
    when "administrace značek"   then "/admin/znacky/"
    else raise "section url not found"
  end
end

def get_form_url(form)
  case form
    when "přidání nové značky" then "/admin/new"
    else raise "form url not found"
  end
end