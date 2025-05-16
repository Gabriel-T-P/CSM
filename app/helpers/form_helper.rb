module FormHelper
  def form_submit_button(label, options = {})
    classes = options[:class] || "w-full py-2 px-4 bg-gray-800 text-white text-sm font-semibold hover:bg-gray-700 transition-colors"
    disabled = options[:disabled] || false

    content_tag :div do
      submit_tag label, class: classes, disabled: disabled
    end
  end

  def form_text_field(form, field, options = {})
    wrapper_classes = options[:wrapper_class] || "mb-4"
    input_classes = options[:input_class] || "mt-1 block w-full px-3 py-2 border border-gray-800 text-gray-800 rounded-none bg-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-gray-800"

    content_tag :div, class: wrapper_classes do
      form.label(field, User.human_attribute_name(field), class: "block text-sm font-medium text-gray-700") +
      form.text_field(field, class: input_classes)
    end
  end

  def form_email_field(form, field, options = {})
    form_text_field(form, field, options.merge(input_type: :email))
  end

  def form_password_field(form, field, options = {})
    wrapper_classes = options[:wrapper_class] || "mb-4"
    input_classes = options[:input_class] || "mt-1 block w-full px-3 py-2 border border-gray-800 text-gray-800 rounded-none bg-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-gray-800"

    content_tag :div, class: wrapper_classes do
      form.label(field, User.human_attribute_name(field), class: "block text-sm font-medium text-gray-700") +
      form.password_field(field, class: input_classes)
    end
  end
end
