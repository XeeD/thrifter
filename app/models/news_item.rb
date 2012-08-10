# encoding: utf-8

class NewsItem < ActiveRecord::Base
  belongs_to :shop

  # Validations
  validates :title,
            presence: true,
            length: {maximum: 100}

  validates :content,
            presence: true

  validates :link,
            length: {maximum: 250}
end