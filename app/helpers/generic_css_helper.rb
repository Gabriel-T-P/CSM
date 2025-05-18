module GenericCssHelper
  def title_h2(title, options = {})
    content_tag :h2, title, {
      class: "text-2xl font-semibold text-center text-gray-800 mb-6"
    }.merge(options)
  end

  def outline_link_to(text, path, color: 'gray', html_options: {})
    base_class = "px-4 py-2 mr-4 font-medium text-#{color}-800 border-2 border-#{color}-800 rounded-none " \
                "hover:border-#{color}-400 hover:text-#{color}-400 transition bg-transparent"

    html_options[:class] = [html_options[:class], base_class].compact.join(' ')
    link_to text, path, html_options
  end

  def outline_button_to(text, path, color: 'gray', method: :post, html_options: {})
    base_class = "px-4 py-2 mr-4 font-medium text-#{color}-800 border-2 border-#{color}-800 rounded-none " \
                "hover:border-#{color}-400 hover:text-#{color}-400 transition bg-transparent"

    html_options[:class] = [html_options[:class], base_class].compact.join(' ')
    button_to text, path, html_options.merge(method: method)
  end
end
