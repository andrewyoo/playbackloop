module ApplicationHelper
  def app_name
    APP_NAME
  end
  
  def app_logo
    str = 'PlaybackL'
    str += fa_icon 'play-circle'
    str += fa_icon 'play-circle'
    str += 'P'
    str
  end

  def title(page_title)
    content_for(:title) { page_title + " | " + app_name }
  end

  def connect_path(provider)
    "/auth/#{provider}"
  end

  def alert_helper(flash_type)
    case flash_type
    when 'success', 'notice' then 'alert-success'
    else 'alert-warning'
    end
  end

  def canonical(url)
    content_for(:canonical) { url }
  end

  def robots(cmd)
    content_for(:robots) { cmd }
  end
  
  def meta_desc(content)
    content_for(:meta_desc) { content }
  end
end
