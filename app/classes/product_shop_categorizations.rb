class ProductShopCategorizations
  attr_reader :product, :shop

  def initialize(product, shop)
    @product = product
    @shop = shop
  end

  def set_alternative_categories!(posted_category_ids)
    category_ids = filter_category_ids(posted_category_ids)

    not_needed_ids = alternative_categories - category_ids
    new_category_ids = category_ids - alternative_categories

    save_to_db(not_needed_ids, new_category_ids)
  end

  private

  def save_to_db(not_needed_category_ids, new_category_ids)
    product.transaction do
      # Delete categorizations that will no longer be used
      not_needed_category_ids.each do |category_id|
        product.alternative_categorizations.where(category_id: category_id).first.destroy
      end

      # Create categorizations pointing to new categories
      new_category_ids.each do |category_id|
        product.alternative_categorizations.create!(category_id: category_id)
      end
    end
  end

  def filter_category_ids(category_ids)
    category_ids.map(&:to_i).find_all do |category_id|
      Category.exists?(id: category_id, shop_id: shop.id)
    end
  end

  def preferred_category
    product.categorizations.in_shop(shop).preferred.pluck(:category_id)
  end

  def alternative_categories
    product.alternative_categories.in_shop(shop).pluck("categories.id")
  end
end