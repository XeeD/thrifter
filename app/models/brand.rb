class Brand < ActiveRecord::Base
  validates :name, :url, :length => {:maximum => 100}, :presence => true
  validates :description, :presence => true
end