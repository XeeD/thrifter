=begin
  Attribute :nested_set => true
  =============================
  provides nested check_boxes on model records

  Attribute :show_if
  ==================
  calls provided method on associated model and based on result displays
  check_box for current choice
=end
class CheckBoxesInput < Formtastic::Inputs::CheckBoxesInput

  def to_html
    if options[:nested_set].present?
      nested_wrapping
    else
      super
    end
  end

  def nested_wrapping
    input_wrapping do
      choices_wrapping do
        legend_html <<
            hidden_field_for_all <<
              choices_group_wrapping do
                # passed collection records
                raw_collection.map { |choice|
                  choice_nested_html(choice)
                }.join("\n").html_safe
              end
      end
    end
  end

  def choice_nested_html(model, nested = false)
    # show checkbox if "show_if" attribute is not provided
    # else call method specified by "show_if" attribute
    # and based on result show check_box
    choice_wrapping(choice_wrapping_html_options([model.send(label_method), model.id])) do
      if options[:show_if].nil? || (options[:show_if].present? && model.send(options[:show_if].to_s))
        choice_html([model.send(label_method), model.id])
      else
        "#{model.send(label_method)}".html_safe
      end << sub_choice_nested_html(model)
    end
  end

  # recursive nesting
  def sub_choice_nested_html(model)
    template.content_tag(:ul, model.children.collect do |child|
      choice_nested_html(child)
    end.join("\n").html_safe, {:class => "sub_item_#{model.id} sub_item"}
    ) unless model.leaf?
  end
end