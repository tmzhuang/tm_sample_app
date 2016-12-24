module UsersHelper
  def gravatar_for(user, size: 80)
    md5 = Digest::MD5::hexdigest(user.email.downcase)
    url = "https://secure.gravatar.com/avatar/#{md5}?s=#{size}"
    image_tag(url, alt: user.name, class: "gravatar")
  end
end
