module ApplicationHelper
  def flash_color(type)
    case type.to_sym
    when :success 
      {
        "bg": "bg-blue-100",
        "border": "border-blue-400",
        "text700": "text-blue-700",
        "text500": "text-blue-500"
      }
    when :danger
      {
        "bg": "bg-red-100",
        "border": "border-red-400",
        "text700": "text-red-700",
        "text500": "text-red-500"
      }
    else
      {
        "bg": "bg-gray-100",
        "border": "border-gray-400",
        "text700": "text-gray-700",
        "text500": "text-gray-500"
      }
    end
  end

  def page_title(title = '', include_base: true)
    base_title = "Review Reflect"
    if title.present?
      include_base ? "#{base_title} | #{title}" : title
    else
      base_title
    end
  end
end
