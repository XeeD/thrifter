# encoding: utf-8

module Admin
  class ParamItemDecorator < Draper::Base
    decorates :param_item

    @assigned_param_values = nil

    def param_group_position
      param_group.position rescue 0
    end

    def param_group_name
      param_group.name rescue nil
    end

    def required
      param_item.is_sortable? ? "required" : ""
    end

    def label_with_group
      h.content_tag :label, for: "param_items_#{param_item.id}", class: required do
        "#{param_item.name} - #{h.content_tag(:small, param_group_name)}".html_safe
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
        input_choices_tags
        # check box fields
      else
        input_check_boxes_tags
      end
    end

    # input text field
    def input_text_tag
      h.text_field_tag(
          "param_items[#{param_item.id}]", "#{@assigned_param_values[param_item.id]}", {type: input_type}
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
        end.join.html_safe <<
          # new field
          h.content_tag(:li, class: "new_value_wrapper") do
            input_new_field_check_box_tag
          end
      end
    end

    def input_check_box_tag(value)
      h.check_box_tag("param_items[#{param_item.id}][]", value, @assigned_param_values.fetch(param_item.id, []).include?(value))
    end

    def input_new_field_check_box_tag
      [
          h.check_box_tag("param_items[#{param_item.id}][]", "", false, {class: "new_value"}),
          h.text_field_tag("new[#{param_item.id}]", "", {"data-copy" => "", class: "new_value_input"}),
          h.content_tag(:span, "Další", class: "add_new_field_link")
      ].join.html_safe
    end

    # radio buttons
    def input_choices_tags
      # bool radio button choices
      if param_item.value_type == "bool"
        input_boolean_choice_tags
      # integer and String radio button choices
      else
        input_radios_tags
      end
    end

    def input_radios_tags
      h.content_tag :ul do
        # existing fields
        param_item.param_values.map do |param_value|
          h.content_tag :li do
            h.content_tag :label, input_radio_tag(param_value.value) + param_value.value
          end
        end.join.html_safe <<
          # new field
          h.content_tag(:li, class: "new_value_wrapper") do
            input_new_field_radio_tag
          end
      end
    end

    def input_boolean_choice_tags
      ParamItem::BOOL_CHOICES.map do |label, value|
        h.content_tag :label, input_radio_tag(value) + label
      end.join.html_safe
    end

    def input_radio_tag(value)
      h.radio_button_tag("param_items[#{param_item.id}]", value.to_s, @assigned_param_values[param_item.id] == value)
    end

    def input_new_field_radio_tag
      radio = h.radio_button_tag("param_items[#{param_item.id}]", "", false, {id: "param_items_#{param_item.id}_new", class: "new_value"})
      input = h.text_field_tag("new[#{param_item.id}]", "", {"data-copy" => "", class: "new_value_input", type: input_type})
      h.content_tag :label, radio + input
    end

    private

    def input_type
      param_item.value_type == "int" ? "number" : "text"
    end
  end
end