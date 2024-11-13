# frozen_string_literal: true

module ApplicationHelper
  def error_messages_for(field)
    if field.errors.any?
      content_tag(:div, field.errors.full_messages.join(", "), class: "text-danger")
    end
  end

  def error_class_for(field)
    "border border-danger-subtle" if field.errors.any?
  end
end
