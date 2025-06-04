module FormFeedbackHelper
  def form_errors(object, attr, css_class: "text-red-500 text-xs mx-2 mt-1 block")
    return unless object&.errors&.[](attr)&.any?

    safe_join(
      object.errors.full_messages_for(attr).map do |msg|
        content_tag(:span, msg, class: css_class)
      end
    )
  end

  def form_success(message)
    return if message.blank?

    content_tag(:span, message, class: "text-blue-600 text-sm mx-2 block")
  end
end
