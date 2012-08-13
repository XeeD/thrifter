# encoding: UTF-8

class Document < ActiveRecord::Base
  has_and_belongs_to_many :shops, join_table: :shop_documents

  validates :name,
            presence: true,
            length: {maximum: 70},
            uniqueness: true

  validates :url,
            presence: true,
            length: {maximum: 70},
            uniqueness: true

  validates :title,
            presence: true,
            length: {maximum: 250}

  validates :content,
            presence: true
end