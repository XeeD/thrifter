# encoding: UTF-8
require 'spec_helper'

describe Category do

  # Associations
  it { should have_many(:categorizations) }
  it { should have_many(:products).through(:categorizations) }
  it { should belong_to(:parent_category).class_name("Category") }
  it { should belong_to(:shop) }

  # Validations
  # short_name
  it { should validate_presence_of(:short_name) }
  it { should ensure_length_of(:short_name).is_at_most(80) }

  # url
  it { should validate_presence_of(:url) }
  it { should ensure_length_of(:url).is_at_most(120) }

  # plural_name
  it { should validate_presence_of(:plural_name) }
  it { should ensure_length_of(:plural_name).is_at_most(120) }

  # singular_name
  it { should ensure_length_of(:singular_name).is_at_most(120) }

  # category_type
  it { should ensure_inclusion_of(:category_type).in_array(Category::CATEGORY_TYPES.values) }

  describe "integrity constraint" do

    let(:category) { Category.new({id: 1}) }

    context "for navigational category type" do
      before do
        category.parent_category = Category.new({id: 2, category_type: "navigational"})
      end

      it "allows navigational category_type for subcategory" do
        category.category_type = "navigational"
        category.valid?
        category.errors_on(:category_type).should_not include("nepovolená kombinace typu kategorie a typu nadřazené kategorie")
      end

      it "allows product_list category_type for subcategory" do
        category.category_type = "product_list"
        category.valid?
        category.errors_on(:category_type).should_not include("nepovolená kombinace typu kategorie a typu nadřazené kategorie")
      end

      it "allows additional category_type for subcategory" do
        category.category_type = "additional"
        category.valid?
        category.errors_on(:category_type).should_not include("nepovolená kombinace typu kategorie a typu nadřazené kategorie")
      end
    end

    context "for product_list category type" do
      before do
        category.parent_category = Category.new({id: 2, category_type: "product_list"})
      end

      it "doesn't allow navigational category_type for subcategory" do
        category.category_type = "navigational"
        category.valid?
        category.errors_on(:category_type).should include("nepovolená kombinace typu kategorie a typu nadřazené kategorie")
      end

      it "doesn't allow product_list category_type for subcategory" do
        category.category_type = "product_list"
        category.valid?
        category.errors_on(:category_type).should include("nepovolená kombinace typu kategorie a typu nadřazené kategorie")
      end

      it "allows additional category_type for subcategory" do
        category.category_type = "additional"
        category.valid?
        category.errors_on(:category_type).should_not include("nepovolená kombinace typu kategorie a typu nadřazené kategorie")
      end
    end

    context "for additional category type" do
      before do
        category.parent_category = Category.new({id: 2, category_type: "additional"})
      end

      it "doesn't allow navigational category_type for subcategory" do
        category.category_type = "navigational"
        category.valid?
        category.errors_on(:category_type).should include("nepovolená kombinace typu kategorie a typu nadřazené kategorie")
      end

      it "doesn't allow product_list category_type for subcategory" do
        category.category_type = "product_list"
        category.valid?
        category.errors_on(:category_type).should include("nepovolená kombinace typu kategorie a typu nadřazené kategorie")
      end

      it "allows additional category_type for subcategory" do
        category.category_type = "additional"
        category.valid?
        category.errors_on(:category_type).should_not include("nepovolená kombinace typu kategorie a typu nadřazené kategorie")
      end
    end

    context "for parent_id" do
      it "does't allow own id (category.parent_id == category.id)" do
        category = Category.new
        category.id = 123
        category.parent_id = category.id
        category.valid?
        category.stub(new_record?: false)
        category.errors_on(:parent_id).should include("nemůže být shodná s danou kategorií")
      end
    end
  end

  context "with valid attributes" do
    it "should be valid" do
      Category.new(valid_category_attributes).should be_valid
    end
  end

  context "#assigned_param_template_id" do
    fixtures :categories

    context "for product list" do
      it "returns it's template id" do
        category = categories(:sporilek_tvs_led)
        category.assigned_param_template_id.should == category.param_template_id
      end
    end

    context "for navigational category"
    it "returns nil" do
      categories(:sporilek_tvs).assigned_param_template_id.should be_nil
    end

    context "for additional category" do
      it "returns the id of it's product_list parent" do
        additional_category = categories(:sporilek_3d_tech_tvs_led)
        product_list_category = additional_category.ancestors.where(category_type: "product_list").first
        additional_category.assigned_param_template_id.should == product_list_category.param_template_id
      end
    end
  end

  describe "#navigational?" do
    it "returns true, if the category is navigational" do
      categories(:sporilek_tvs).should be_navigational
    end

    it "return false, if the category is of other type" do
      categories(:sporilek_tvs_led).should_not be_navigational
    end
  end

  describe "#product_list?" do
    it "returns true, if the category is navigational" do
      categories(:sporilek_tvs_led).should be_product_list
    end

    it "return false, if the category is of other type" do
      categories(:sporilek_tvs).should_not be_product_list
    end
  end

  describe "#additional?" do
    it "returns true, if the category is additional" do
      categories(:sporilek_combined_fridges_up).should be_additional
    end

    it "return false, if the category is of other type" do
      categories(:sporilek_tvs_led).should_not be_additional
    end
  end

  describe "#path_to_node" do
    let(:category) { categories(:sporilek_3d_tech_tvs_plasma) }

    it "returns all ancestors of the category" do
      ancestor = categories(:sporilek_3d_tech)
      expect(category.path_to_node).to include(ancestor)
    end

    describe "#to_s" do
      it "converts the category short_names to one string joined by ->" do
        expect(category.path_to_node.to_s).to  eq("3D technologie → Televize → Plazmové")
      end
    end
  end
end