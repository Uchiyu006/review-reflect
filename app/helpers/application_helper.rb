module ApplicationHelper
  def flash_color(type)
    case type.to_sym
      when :success then "blue"
      when :danger  then "red"
      else "gray"
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
