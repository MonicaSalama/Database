module UsersHelper

  # Returns the Gravatar for the given user.
  def gravatar_for(user, options = { size: 80 })
    size = options[:size]
    image_tag(user.gender.downcase + ".jpg", alt: user.firstname + " " + user.lastname)
  end
end
