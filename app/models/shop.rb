class Shop < ActiveRecord::Base
  # Associations
  has_many :categories
  has_many :news_items
  has_many :articles, through: :categories, group: "articles.id"

  has_and_belongs_to_many :shipping_methods, join_table: :shop_has_shipping_methods
  has_and_belongs_to_many :payment_methods, join_table: :shop_has_payment_methods
  has_and_belongs_to_many :documents, join_table: :shop_documents

  # Attributes
  attr_accessible :host, :name, :short_name

  default_scope -> { order(:name) }
  
  # Validations
  validates :host,
            presence: true,
            length: {maximum: 20, minimum: 3},
            uniqueness: true

  validates :name,
            presence: true,
            length: {maximum: 20},
            uniqueness: true

  validates :short_name,
            presence: true,
            length: {maximum: 20},
            uniqueness: true
end
