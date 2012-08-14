# encoding: UTF-8
module Admin
  class ShopDecorator < Draper::Base
    decorates :shop
    #decorates_association :articles, with: Admin::ArticleDecorator
  end
end