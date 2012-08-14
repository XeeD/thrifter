# encoding: UTF-8

module Admin
  class DocumentDecorator < Draper::Base
    decorates :document

    def assigned_to_shops
      unless shops.empty?
        shops.collect(&:name).to_sentence
      else
        h.content_tag :em, "Není přiřazen"
      end
    end
  end
end