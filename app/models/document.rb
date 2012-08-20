# encoding: UTF-8

class Document < ActiveRecord::Base
  has_and_belongs_to_many :shops, join_table: :shop_documents

  before_save :remove_old_contact_link

  transliterate_permalink :url

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

  private

  def remove_old_contact_link
    if contact_link
      # Only one document can be marked as contact_link
      Document.update_all(contact_link: false)
    end
  end
end