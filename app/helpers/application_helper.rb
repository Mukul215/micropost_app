module ApplicationHelper

  # Returns the full title on a per-page basis.
  # If no title is there, base title will automatically be filled in
  def full_title(page_title = ' ')
    base_title = "Ruby on Rails Sample App"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

end
