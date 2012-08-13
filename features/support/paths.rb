# encoding: UTF-8

def get_section_url(section)
  case section
    when "administrace produktů"  then admin_products_path
    when "administrace značek"    then admin_brands_path
    when "administrace kategorií" then admin_categories_path
    when "administrace šablon parametrů" then admin_param_templates_path
    when "administrace obchodů" then admin_shops_path
    when "administrace novinek" then admin_news_items_path
    when "administrace dokumentů" then admin_documents_path
    when "administrace článků" then admin_articles_path
    else raise "section url for '#{section}' was not found"
  end
end