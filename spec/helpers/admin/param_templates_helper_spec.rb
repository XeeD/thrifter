module Admin
  describe ParamTemplatesHelper do
    describe "#category_roots_for_shop" do
      fixtures :shops

      it "returns all tree roots for Category with given shop_id" do
        shop = shops(:sporilek)
        categories = shop.categories.where(:parent_id => nil)
        helper.category_roots_for_shop(shop) == categories
      end
    end
  end
end