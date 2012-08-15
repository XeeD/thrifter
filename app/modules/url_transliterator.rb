module UrlTransliterator
  def transliterate_to_ascii(attribute)
    setter = "#{attribute}=".to_sym

    define_method setter do |value|
      self[attribute] = value.downcase
    end

    validates attribute, format: {with: /[a-z-]/}
  end
end