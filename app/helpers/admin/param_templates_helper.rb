module Admin::ParamTemplatesHelper
  def category_roots_for_shop(shop)
    Category.roots.where(shop_id: shop.id)
  end

  def category_select_for_shop(shop, form, options)
    options.reverse_merge!(
        as: :check_boxes,
        collection: category_roots_for_shop(shop),
        nested_set: true,
        member_label: :plural_name)

    form.input :categories, options
  end

  def already_assigned_categories
    Category.where("param_template_id IS NOT NULL").pluck(:id) - param_template.categories.pluck(:id)
  end
end