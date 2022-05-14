module ApplicationHelper
  def user_avatar(user)
    if user.avatar?
      user.avatar.url
    else
      asset_path('user.png')
    end
  end

  def fa_icon(icon_class)
    content_tag 'i', '', class: "bi bi-#{icon_class}"
  end
end
