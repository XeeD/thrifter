module ProductsHelper
  def section_path(section)
    "/#{params[:category_url]}/#{params[:product_url]}/#{section.downcase}".html_safe
  end
end