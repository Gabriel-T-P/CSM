module GenericCssHelper
  def title_h2(title, options = {})
    content_tag :h2, title, {
      class: "text-2xl font-semibold text-center text-gray-800 mb-6"
    }.merge(options)
  end
end
