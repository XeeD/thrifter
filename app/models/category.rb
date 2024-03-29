# encoding: UTF-8

class Category < ActiveRecord::Base
  # Macros
  acts_as_nested_set scope: :shop

  transliterate_permalink :url

  # Associations
  has_many :categorizations
  has_many :products, through: :categorizations

  belongs_to :shop
  belongs_to :param_template
  belongs_to :parent_category, foreign_key: :parent_id, class_name: "Category"

  has_and_belongs_to_many :articles, join_table: :category_articles

  # Scopes
  scope :in_shop, ->(shop_id) { where(shop_id: shop_id) }

  # Attributes
  attr_accessible :short_name, :url, :plural_name, :singular_name, :category_type, :parent_id

  def category_type
    self[:category_type] && self[:category_type].to_sym
  end

  def category_type=(category_type)
    self[:category_type] = category_type && category_type.to_s
  end

  # Instance methods
  def assigned_param_template_id
    case category_type
      when :product_list
        param_template_id
      when :additional
        ancestors.where(category_type: :product_list).pluck(:param_template_id).first
      else
        nil
    end
  end

  def assigned_param_template
    case category_type
      when :product_list
        param_template
      when :additional
        ancestors.where(category_type: :product_list).first.param_template
      else
        nil
    end
  end

  def path_to_node
    @path_to_node ||= PathToNode.new(self)
  end

  class PathToNode
    def initialize(category)
      @category = category
      @categories = category.self_and_ancestors
    end

    def to_s
      @categories.map(&:short_name).join(" → ")
    end

    # Delegate all other method calls to underlying collection of categories
    def method_missing(method, args)
      @categories.send(method, *args)
    end
  end

  # Enumerations
  CATEGORY_TYPES = {
      "Navigační" => :navigational,
      "Produktová" => :product_list,
      "Přídavná" => :additional
  }

  # Define methods like Category#navigational? and Category#product_list?
  CATEGORY_TYPES.values.each do |category_type|
    predicate_method = (category_type.to_s + "?").to_sym

    define_method predicate_method do
      self.category_type == category_type
    end
  end

  # Validations
  validates :short_name,
            presence: true,
            length: {maximum: 80}

  validates :url,
            presence: true,
            length: {maximum: 120}

  validates :plural_name,
            presence: true,
            length: {maximum: 120}

  validates :singular_name,
            length: {maximum: 120}

  validates :category_type,
            presence: true,
            inclusion: {in: CATEGORY_TYPES.values},
            parent_field_combination: {
                :navigational => [:navigational, :product_list, :additional],
                :product_list => [:additional],
                :additional => [:additional]
            }
  validates :parent_id,
            parent_loop: true
end