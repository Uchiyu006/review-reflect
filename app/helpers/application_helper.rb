module ApplicationHelper
  def flash_color(type)
    case type.to_sym
      when :success then "blue"
      when :danger  then "red"
      else "gray"
    end
  end

  def page_title(title = '')
    if title.present?
      "#{title}"
    end
  end
end
