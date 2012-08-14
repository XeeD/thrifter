# encoding: UTF-8
module Admin
  class ArticleDecorator < Draper::Base
    decorates :article

    #def assigned_to_categories
    #  categories.collect(&:short_name).to_sentence
    #end
  end
end