class UrlInput < Formtastic::Inputs::UrlInput
  def to_html
    if @object.new_record? && options[:suggest_url].present?
      suggest_from = "#{@object_name}_#{options[:suggest_url] == true ? 'name' : options[:suggest_url]}"

      input_wrapping do
        label_html <<
            builder.url_field(
                method,
                input_html_options.merge({"data-suggest-from" => suggest_from}
                )
            )
      end
    else
      super
    end
  end
end