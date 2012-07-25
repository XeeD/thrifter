class CheckBoxesInput < Formtastic::Inputs::CheckBoxesInput

  def to_html
    unless options[:nested_set]
      super
    else
      nested_wrapping
    end
  end

  def nested_wrapping
    choices_wrapping do
      legend_html <<
          hidden_field_for_all <<
          choices_group_wrapping do
            collection.map {|choice|
              choice_wrapping(choice_wrapping_html_options(choice)) do
                choice_nested_html(choice)
              end
            }.join("\n").html_safe
          end
    end
  end

  def choice_nested_html(choice, nested = false)
    form_nested = nested ? "" : sub_choice_nested_html(choice)
    choice_html(choice) << form_nested
  end

  def sub_choice_nested_html(choice)
    name, id = choice
    model = sanitized_method_name.singularize.classify.constantize.find(id)
    template.content_tag(:ul, model.children.collect do |child|
        choice_nested_html([child.send(label_method), child.id], true)
      end.join("\n").html_safe, {:style => "margin-left:20px", :class => "sub_item-#{choice.last} sub-item"}
    ) unless model.leaf?
    end
end