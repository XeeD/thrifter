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

    describe "#already_assigned_categories_for_param_templates" do
      fixtures :param_templates

      it "returns all categories that are already assigned to different templates" do
        param_template = param_templates(:fridges)
        helper.stub(param_template: param_template)
        assigned = Category.where("param_template_id IS NOT NULL").pluck(:id) - param_template.categories.pluck(:id)
        helper.already_assigned_categories_for_param_templates.should == assigned
      end
    end
  end
end