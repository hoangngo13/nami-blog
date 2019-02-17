module UsersHelper
  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_ulr ="https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_ulr, alt: user.username, class:"img-circle")
  end
end
