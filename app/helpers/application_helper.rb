module ApplicationHelper
  # Returns the full titel on a per-page basis
  def full_title(page_title='')
    base_title = "tm-sample-app"
    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end
end
