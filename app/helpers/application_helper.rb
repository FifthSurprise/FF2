module ApplicationHelper
  require 'redcarpet/compat'
  include ActionView::Helpers::SanitizeHelper
  
  # def avatar_for(user, size = 100)
  #   default_url = "#{root_url}images/guest.png"
  #   pixels = size
  #   gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
  #   default_url = "#{root_url}images/guest.png"
  #   "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{pixels}"
  # end

  def mini_avatar(user)
    pixels = 50
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    default_url = "#{root_url}images/guest.png"
    "https://secure.gravatar.com/avatar/#{gravatar_id}.png?s=#{pixels}"
  end


  def markdown(text)
    options = [:hard_wrap, :filter_html, :autolink, :no_intraemphasis, :fenced_code, :gh_blockcode]
    Markdown.new(text, *options).to_html.html_safe
  end

  def sanitize(text)
    strip_tags(markdown(text))
  end

end
