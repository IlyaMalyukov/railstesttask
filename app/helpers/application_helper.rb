module ApplicationHelper
  # Возвращает полный заголовок на основе заголовка страницы.
  def full_title(page_title = '')
      base_title = "Rails Test Task"
      if page_title.empty?
        base_title
      else
        "#{page_title} | #{base_title}"
      end
    end
  end
