class Article < ActiveRecord::Base

  # Associations
  has_and_belongs_to_many :categories, join_table: :category_articles
  has_many :shops, through: :categories

  transliterate_permalink :url

  default_scope -> { order(:name) }

  # Validations
  validates :name,
            presence: true,
            length: {maximum: 100}

  validates :url,
            presence: true,
            length: {maximum: 100}

  validates :title,
            presence: true,
            length: {maximum: 250}

  validates :content,
            presence: true

  validates :summary,
            presence: true

  validates :categories,
            presence: true
end