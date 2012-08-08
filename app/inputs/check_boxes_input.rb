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


  def check_box_without_hidden_input(choice)
    value = choice_value(choice)
    input_tag(
        input_name,
        value,
        checked?(value),
        input_html_options.merge(:id => choice_input_dom_id(choice), :disabled => disabled?(value), :required => false)
    )
  end

  def input_tag(*args)
    options[:as_radio_buttons] ? template.radio_button_tag(*args) : template.check_box_tag(*args)
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
    label = model.send(label_method)
    choice_wrapping(choice_wrapping_html_options([label, model.id])) do
      if show_box?(model)
        choice_html([label, model.id])
      else
        label.to_s.html_safe
      end << sub_choice_nested_html(model)
    end
  end

  def show_box?(model)
    # Default behavior: show all checkboxes
    return true if options[:show_if].nil?

    # We show the element if at least one of :show_if methods returns true
    [*options[:show_if]].detect { |show_method| model.send(show_method.to_sym) }
  end

  # recursive nesting
  def sub_choice_nested_html(model)
    template.content_tag(:ul, model.children.collect do |child|
      choice_nested_html(child)
    end.join("\n").html_safe, {:class => "sub_item_#{model.id} sub_item"}
    ) unless model.leaf?
  end
end