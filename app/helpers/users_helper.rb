module UsersHelper

  def gravatar_for(user, options = { size: 80 })
    hashed_email = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{hashed_email}?s=#{size}&d=identicon"
    image_tag(gravatar_url, size: size, alt: user.name, class: 'gravatar')
  end
end
