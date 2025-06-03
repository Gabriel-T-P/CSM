module ErrorFormHelper
  def form_errors(object, attr, css_class: "text-red-500 text-xs mt-1 block")
    return unless object&.errors&.[](attr)&.any?

    safe_join(
      object.errors.full_messages_for(attr).map do |msg|
        content_tag(:span, msg, class: css_class)
      end
    )
  end
end
