module ApplicationHelper

  def nav_link_to(link, url)
    if current_page?(url)
      link_to link, url, class: "active"
    else
      link_to link, url
    end
  end
	
end
