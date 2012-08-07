# encoding: utf-8
class Admin::ParamItemDecorator < Draper::Base
  decorates :param_item

  @assigned_param_values = nil

  def param_group_position
    param_group.position rescue 0
  end

  def param_group_name
    param_group.name rescue nil
  end

  def required
    param_item.is_sortable? ? "*" : ""
  end

  def label_with_group
    h.content_tag :label, for: "param_items_#{param_item.id}" do
      "#{param_item.name} - #{param_group_name} #{required}"
    end
  end

  # generate input fields based on ParamItem choice_type
  def param_item_input_fields(assigned_param_values)
    @assigned_param_values = assigned_param_values
    # input text field
    if param_item.choice_type == "input"
      input_text_tag
    # radio button fields
    elsif param_item.choice_type == "choices"
      input_choice_tags
    # check box fields
    else
      input_check_boxes_tags
    end
  end

  # input text field
  def input_text_tag
    h.text_field_tag(
        "param_items[#{param_item.id}]", "#{@assigned_param_values[param_item.id]}", {size: input_size}
    ).concat(" #{param_item.unit}")
  end

  # check box fields
  def input_check_boxes_tags
    h.content_tag :ul do
      # existing fields
      param_item.param_values.map do |param_value|
        h.content_tag :li do
          h.content_tag :label, input_check_box_tag(param_value.value) + param_value.value
        end
      end.join.html_safe.concat(
        # new field
        h.content_tag(:li, class: "new_value_wrapper") do
          input_new_field_check_box_tag
        end
      )
    end
  end

  def input_check_box_tag(value)
    h.check_box_tag("param_items[#{param_item.id}][]", value, @assigned_param_values.fetch(param_item.id, []).include?(value))
  end

  def input_new_field_check_box_tag
      check_box = h.check_box_tag("param_items[#{param_item.id}][]", "", false, {class: "new_value"})
      input = h.text_field_tag("new[#{param_item.id}]", "", {"data-copy" => "", class: "new_value_input"})
      link = h.content_tag(:span, "Další", class: "add_new_field_link")
      check_box + input + link
  end

  # radio buttons
  def input_choice_tags
    # bool radio button choices
    if param_item.value_type == "bool"
      ParamItem::BOOL_CHOICES.map do |label, value|
        h.content_tag :label, input_radio_tag(value) + label
      end.join.html_safe
    # integer and String radio button choices
    else
      h.content_tag :ul do
        # existing fields
        param_item.param_values.map do |param_value|
          h.content_tag :li do
            h.content_tag :label, input_radio_tag(param_value.value) + param_value.value
          end
        end.join.html_safe.concat(
          # new field
          h.content_tag(:li, class: "new_value_wrapper") do
            input_new_field_radio_tag
          end
        )
      end
    end
  end

  def input_radio_tag(value)
    h.radio_button_tag("param_items[#{param_item.id}]", value.to_s, @assigned_param_values[param_item.id] == value)
  end

  def input_new_field_radio_tag
      radio = h.radio_button_tag("param_items[#{param_item.id}]", "", false, {id: "param_items_#{param_item.id}_new", class: "new_value"})
      input = h.text_field_tag("new[#{param_item.id}]", "", {"data-copy" => "", class: "new_value_input", size: input_size})
      h.content_tag :label, radio + input
  end

  private
  
  def input_size
    param_item.value_type == "int" ? 5 : 20
  end
end